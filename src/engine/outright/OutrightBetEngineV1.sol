// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol";
import "src/engine/outright/interface/IOutrightBetEngineV1.sol";
import "src/engine/outright/BettingHandler.sol";
import "src/interface/IOracleV1.sol";
import "src/lib/SettlementHandler.sol";
import "src/lib/Signature.sol";

contract OutrightBetEngineV1 is IOutrightBetEngineV1 {

    uint256 private priceFactor;

    // token map for free bet
    mapping(address => address) tokenMap;

    constructor(uint256 _priceFactor) {
        priceFactor = _priceFactor;
    }

    function settleBet(
        uint256 leagueId,
        address oracle,
        bytes calldata ticketBytes
    )
        external
        view
        override
        returns (
            Settlement.SettlementV1 memory settlement
        )
    {
        OutrightBetTicketV1.OutrightBet memory ticket = abi.decode(
            ticketBytes,
            (OutrightBetTicketV1.OutrightBet)
        );

        (Status.OutrightTeamStatus resultStatus, uint256 deadHeat) =
            IOracleV1(oracle).getOutrightResult(leagueId, ticket.teamId);
        
        Status.TicketStatus ticketStatus = SettlementHandler.settleOutright(
            resultStatus,
            ticket.payout,
            ticket.stake,
            deadHeat
        );

        return SettlementHandler.getSettlement(
            ticket.transId,
            ticketStatus,
            ticket.token,
            tokenMap[ticket.token],
            ticket.customer,
            ticket.payoutAddress,
            ticket.stake,
            ticket.payout,
            deadHeat
        );
    }

    function processTicket(
        address signer,
        uint nonce,
        bytes calldata sourceTicketBytes
    )
        external
        view
        override
        returns (
            Receipt.BetReceiptV1 memory,
            bytes memory
        )
    {
        (
            OutrightBetTicketV1.SourceOutrightBet memory source,
            Signature.Vrs memory signature
        ) = abi.decode(
            sourceTicketBytes,
            (OutrightBetTicketV1.SourceOutrightBet, Signature.Vrs)
        );

        require(block.number <= source.deadlineBlock, "CustomErrors: block number is over the deadline");

        bytes32 ticketHash = createTicketHash(source.customer, nonce, source);
        bytes32 message = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n", Strings.toString(ticketHash.length), ticketHash));
        address recovered = ECDSA.recover(message, signature.v, signature.r, signature.s);
        require(recovered == signer, "CustomErrors: invalid signature");

        uint256 payout;
        uint256 stake;
        (payout, stake) = BettingHandler.getStakeAndPayout(
            source.oddsType,
            source.displayPrice,
            source.displayStake,
            100
        );
        require(payout > 0, "CustomErrors: odds type is not supported yet");

        Receipt.TokenClaimDto[] memory tokenClaimDtos;
        tokenClaimDtos = new Receipt.TokenClaimDto[](2);
        address payoutToken = source.token;
        if (tokenMap[source.token] != address(0)) {
            payoutToken = tokenMap[source.token];
        }
        tokenClaimDtos[0] = Receipt.TokenClaimDto(
            source.customer,
            source.token,
            stake
        );
        tokenClaimDtos[1] = Receipt.TokenClaimDto(
            source.payoutAddress,
            payoutToken,
            payout - stake
        );

        return (
            Receipt.BetReceiptV1(
                source.transId,
                source.customer,
                tokenClaimDtos
            ),
            abi.encode(OutrightBetTicketV1.OutrightBet(
                source.transId,
                source.leagueId,
                source.teamId,
                payout,
                stake,
                source.customer,
                source.payoutAddress,
                source.token,
                source.status,
                source.deadlineBlock)
            )
        );
    }

    function rejectBet(
        bytes calldata bytesTicket
    )
        external
        pure
        override
        returns (
            Settlement.ERC20PaymentV1[] memory
        )
    {
        OutrightBetTicketV1.OutrightBet memory ticket = abi.decode(
            bytesTicket,
            (OutrightBetTicketV1.OutrightBet)
        );

        Settlement.ERC20PaymentV1[] memory payments = new Settlement.ERC20PaymentV1[](2);
        payments[0] = Settlement.ERC20PaymentV1(
            ticket.token,
            ticket.customer,
            ticket.stake
        );
        payments[1] = Settlement.ERC20PaymentV1(
            ticket.token,
            ticket.payoutAddress,
            ticket.payout - ticket.stake
        );
        return payments;
    }

    function createTicketHash(
        address customer,
        uint256 nonce,
        OutrightBetTicketV1.SourceOutrightBet memory source
    )
        private
        pure
        returns (bytes32)
    {
        return keccak256(abi.encode(
            customer,
            nonce,
            1,
            source
        ));
    }
}
