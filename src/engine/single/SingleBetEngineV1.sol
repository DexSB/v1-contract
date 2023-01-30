// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol";
import "src/engine/single/BettingHandler.sol";
import "src/engine/single/interface/ISingleBetEngineV1.sol";
import "src/interface/IOracleV1.sol";
import "src/lib/oracle/EventResultV1.sol";
import "src/lib/oracle/EventHandlerV1.sol";
import "src/lib/single/SingleBetTicketV1.sol";
import "src/lib/ResultHandler.sol";
import "src/lib/SettleConditionsHandler.sol";
import "src/lib/SettlementHandler.sol";
import "src/lib/SettlePatternHandler.sol";
import "src/lib/Signature.sol";
import "src/lib/Status.sol";

contract SingleBetEngineV1 is ISingleBetEngineV1 {
    // times of price being incresed, price should be deciaml so it'll be multiply with this variable
    uint256 private priceFactor;
    // times of handicap point being incresed, handicap point should be deciaml so it'll be multiply with this variable
    uint256 private hdpFactor;

    // token map for free bet
    mapping(address => address) tokenMap;

    constructor(uint256 _priceFactor, uint256 _hdpFactor) {
        priceFactor = _priceFactor;
        hdpFactor = _hdpFactor;
    }

    function settleBet(
        uint256 eventId,
        address oracle,
        bytes calldata ticketBytes
    )
        external
        view
        override
        returns (Settlement.SettlementV1 memory settlement)
    {
        // decode the ticket in bytes to a SingleBetTicketV1 object to extract the value of needed
        SingleBetTicketV1.SingleBet memory ticket = abi.decode(
            ticketBytes,
            (SingleBetTicketV1.SingleBet)
        );

        // get result status to check if event has been set to refund or not
        Status.ResultStatus resultStatus = IOracleV1(oracle).getEventStatus(
            eventId
        );
        // get how to settle with ticket's bet type and result status
        SettlePatternHandler.SettlePattern settlePattern = SettlePatternHandler
            .getSettlePattern(ticket.betType, resultStatus, ticket.resource1);

        if (settlePattern != SettlePatternHandler.SettlePattern.Refund) {
            // get score will return what type of score should be return base on betType and resource1
            (uint256 homeScore, uint256 awayScore) = IOracleV1(oracle).getScore(
                eventId,
                ticket.sportType,
                ticket.betType,
                ticket.resource1
            );

            int256 ticketResult;
            bytes32 resultHash;
            Status.TicketStatus ticketStatus;
            {
                if (settlePattern == SettlePatternHandler.SettlePattern.Score) {
                    // ticket result is an result score after all required calculation base on betType
                    // and the live score at the moment of bet placing
                    ticketResult = ResultHandler.getTicketResult(
                        homeScore,
                        awayScore,
                        ticket.sportType,
                        ticket.betType,
                        ticket.liveHomeScore,
                        ticket.liveAwayScore,
                        ticket.hdp1,
                        ticket.hdp2,
                        hdpFactor
                    );
                } else if (
                    settlePattern == SettlePatternHandler.SettlePattern.ResultHash
                ) {
                    // for those betType required key and result comparison only
                    resultHash = IOracleV1(address(oracle)).getResultHash(
                        eventId,
                        ticket.sportType,
                        ticket.betType,
                        ticket.resource1
                    );
                }

                // after the ticketResult/resultHash be defined, the ticket could be settle with result and key comparison
                ticketStatus = SettlementHandler
                    .settleSingleBetTicket(
                        ticketResult,
                        ticket.keyHash,
                        ticket.betType,
                        SettleConditionsHandler.getConditions(
                            ticket.betType,
                            resultHash
                        ),
                        ticket.payout,
                        ticket.stake,
                        hdpFactor
                    );
            }

            return SettlementHandler.getSettlement(
                ticket.transId,
                ticketStatus,
                ticket.token,
                tokenMap[ticket.token],
                ticket.customer,
                ticket.payoutAddress,
                ticket.stake,
                ticket.payout,
                1
            );
        } else {
            // refund should return the stake to customer and the rest should return to payout wallet
            address payoutToken = ticket.token;
            if (tokenMap[ticket.token] != address(0)) {
                payoutToken = tokenMap[ticket.token];
            }
            Settlement.ERC20PaymentV1[] memory payments;
            payments = new Settlement.ERC20PaymentV1[](2);
            // amount to customer
            payments[0] = (
                Settlement.ERC20PaymentV1(
                    ticket.token,
                    ticket.customer,
                    ticket.stake
                )
            );
            // amount to payout address
            payments[1] = (
                Settlement.ERC20PaymentV1(
                    payoutToken,
                    ticket.payoutAddress,
                    ticket.payout - ticket.stake
                )
            );

            settlement = Settlement.SettlementV1(
                ticket.transId,
                ticket.customer,
                ticket.token,
                ticket.stake,
                Status.TicketStatus.Refund,
                payments
            );
        }
    }

    function processTicket(
        address signer,
        uint nonce,
        bytes calldata sourceTicketBytes
    )
        external
        view
        override
        returns (Receipt.BetReceiptV1 memory, bytes memory)
    {
        // decode ticket for further calculation
        (
            SingleBetTicketV1.SourceSingleBet memory source,
            Signature.Vrs memory signature
        ) = abi.decode(
                sourceTicketBytes,
                (SingleBetTicketV1.SourceSingleBet, Signature.Vrs)
            );
        // force player to send the transaction before a block number
        // avoid some player not send out the transaction when they lose the game
        require(
            block.number <= source.deadlineBlock,
            "CustomErrors: block number is over the deadline"
        );

        // to makes sure the ticket is varified by thee system and not been modified
        bytes32 ticketHash = createTicketHash(source.customer, nonce, source);
        bytes32 message = keccak256(
            abi.encodePacked(
                "\x19Ethereum Signed Message:\n",
                Strings.toString(ticketHash.length),
                ticketHash
            )
        );
        address recovered = ECDSA.recover(
            message,
            signature.v,
            signature.r,
            signature.s
        );
        require(recovered == signer, "CustomErrors: invalid signature");

        // calculate the max payout and the actual stake of the ticket
        (uint256 payout, uint256 stake) = BettingHandler.getStakeAndPayout(
            source.oddsType,
            source.displayPrice,
            source.displayStake,
            priceFactor
        );

        require(payout > 0, "CustomErrors: odds type is not supported yet");

        address payoutToken = source.token;
        bool isFreeBetToken = false;
        if (tokenMap[source.token] != address(0)) {
            payoutToken = tokenMap[source.token];
            isFreeBetToken = true;
        }

        Receipt.TokenClaimDto[] memory tokenClaimDtos;
        tokenClaimDtos = new Receipt.TokenClaimDto[](2);
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

        // return receipt and encode ticket to bytes
        return (
            Receipt.BetReceiptV1(
                source.transId,
                source.customer,
                tokenClaimDtos
            ),
            abi.encode(
                SingleBetTicketV1.SingleBet(
                    source.transId,
                    source.sportType,
                    source.eventId,
                    source.betType,
                    keccak256(abi.encode(source.key)),
                    source.liveHomeScore,
                    source.liveAwayScore,
                    source.oddsType,
                    payout,
                    stake,
                    source.customer,
                    source.payoutAddress,
                    source.token,
                    source.hdp1,
                    source.hdp2,
                    source.resource1,
                    source.status,
                    source.deadlineBlock
                )
            )
        );
    }

    function rejectBet(
        bytes calldata ticketBytes
    ) external view override returns (Settlement.ERC20PaymentV1[] memory) {
        // decode ticket
        SingleBetTicketV1.SingleBet memory ticket = abi.decode(
            ticketBytes,
            (SingleBetTicketV1.SingleBet)
        );

        address payoutToken = ticket.token;
        bool isFreeBetToken = false;
        if (tokenMap[ticket.token] != address(0)) {
            payoutToken = tokenMap[ticket.token];
            isFreeBetToken = true;
        }

        // create payment for reject
        Settlement.ERC20PaymentV1[]
            memory payments = new Settlement.ERC20PaymentV1[](2);
        payments[0] = Settlement.ERC20PaymentV1(
            ticket.token,
            ticket.customer,
            ticket.stake
        );
        payments[1] = Settlement.ERC20PaymentV1(
            payoutToken,
            ticket.payoutAddress,
            ticket.payout - ticket.stake
        );
        return payments;
    }

    // create ticket hash with ticket bytes
    function createTicketHash(
        address customer,
        uint256 nonce,
        SingleBetTicketV1.SourceSingleBet memory source
    ) private pure returns (bytes32) {
        return keccak256(abi.encode(customer, nonce, 1, source));
    }

    function setFreeBetToken(
        address freeBetToken,
        address payoutToken
    ) external {
        tokenMap[freeBetToken] = payoutToken;
    }
}
