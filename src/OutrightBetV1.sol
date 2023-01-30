// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-contracts/contracts/utils/Counters.sol";
import "src/interface/IOutrightBetV1.sol";
import "src/lib/outright/BytesTicketMap.sol";
import "src/lib/Receipt.sol";
import "src/lib/Settlement.sol";
import "src/utils/BaseOwnablePausable.sol";

contract OutrightBetV1 is BaseOwnablePausable, IOutrightBetV1 {

    using Counters for Counters.Counter;
    using BytesTicketMap for BytesTicketMap.OutrightBetTicketMapV1;

    address signer;
    address settler;
    address rejecter;
    address oracle;

    mapping(address => Counters.Counter) nonces;
    mapping(uint256 => address) versionEngineMap;

    BytesTicketMap.OutrightBetTicketMapV1 ticketsV1;

    function initialize(
        address _signer,
        address _settler,
        address _rejecter,
        address _oracle
    ) public initializer {
        BaseOwnablePausable.initialize();
        signer = _signer;
        settler = _settler;
        rejecter = _rejecter;
        oracle = _oracle;
    }

    function settleBet(
        uint256 leagueId,
        uint256[] calldata transIds
    )
        external
        override
    {
        // this function must be called by settler account
        require(msg.sender == settler, "CustomErrors: caller is not the settler");

        for (uint256 i; i < transIds.length; i++) {
            // try get ticket from storage
            (bool isExist, BytesTicket.OutrightBetTicketV1 memory bytesTicket) = ticketsV1.tryGet(transIds[i]);
            if (isExist) {
                // call the specific version of engine to process the settle bet, it'll return the settlement and payments
                (bool isSuccess, bytes memory response) = versionEngineMap[bytesTicket.version].call(
                    abi.encodeWithSignature(
                        "settleBet(uint256,address,bytes)",
                        leagueId,
                        oracle,
                        bytesTicket.signedTicketBytes
                    )
                );

                if (isSuccess) {
                    // decode the response to settlement and payment
                    Settlement.SettlementV1 memory settlement = abi.decode(
                        response,
                        (Settlement.SettlementV1)
                    );

                    if (settlement.customer != address(0)) {
                        // sent token with the info of payments
                        for (uint8 j; j < settlement.payments.length; j++) {
                            Settlement.ERC20PaymentV1 memory payment = settlement.payments[j];
                            require(IERC20(payment.token).transfer(payment.receiver, payment.amount),"CustomerError: token transfer error");
                        }

                        // emit the logs for off-chain service to update the database
                        emit OutrightTicketSettled(
                            settlement.transId,
                            settlement.customer,
                            settlement.token,
                            settlement.amountToCustomer,
                            settlement.status
                        );

                        // remove ticket from storage
                        ticketsV1.remove(transIds[i]);
                    } else {
                        // emit the log if anything wrong, it'll notify our off-chain service to mark down the error
                        emit OutrightBetSettlementNull(transIds[i]);
                    }
                } else {
                    // extract message of engine error from memory, and revert this transaction with the message
                    assembly {
                        revert(add(response, 32), mload(response))
                    }
                }
            }
        }
    }

    function placeOutrightBet(
        uint256 version,
        bytes calldata signedTicketBytes
    )
        external
        override
        whenNotPaused
    {
        // call sepcific version of engine to handle the ticket validation and required calculation it'll return the receipt
        (bool isSuccess, bytes memory response) = versionEngineMap[version].call(
            abi.encodeWithSignature(
                "processTicket(address,uint256,bytes)",
                signer,
                nonces[msg.sender].current(),
                signedTicketBytes
            )
        );

        if (isSuccess) {
            // decode response to receipt and ticket in bytes format
            (Receipt.BetReceiptV1 memory receipt, bytes memory ticket) = abi.decode(
                response,
                (Receipt.BetReceiptV1, bytes)
            );

            for (uint256 i; i < receipt.tokenClaimDtos.length; i++) {
                Receipt.TokenClaimDto memory tokenClaimDto = receipt
                    .tokenClaimDtos[i];
                require(
                    IERC20(tokenClaimDto.token).transferFrom(
                        tokenClaimDto.account,
                        address(this),
                        tokenClaimDto.amount
                    ),
                    "CustomErrors: token transfer error"
                );
            }

            // create bytes ticket object
            BytesTicket.OutrightBetTicketV1 memory bytesTicket = BytesTicket.OutrightBetTicketV1(
                version, ticket
            );
            ticketsV1.set(receipt.transId, bytesTicket);

            // nonce increament
            nonces[msg.sender].increment();
            // send event for off-chain system to update database
            emit OutrightBetPlaced(receipt.transId, receipt.customer);
        } else {
            // extract message from engine call memory, and revert this transaction with error message
            assembly {
                revert(add(response, 32), mload(response))
            }
        }
    }

    function rejectBet(
        uint256[] calldata transIds
    )
        external
        override
    {
        // this function must be called by rejecter account
        require(msg.sender == rejecter, "CustomErrors: caller is not the rejecter");
        for (uint256 i; i < transIds.length; i++) {
            // try get ticket from storage
            (bool isExist, BytesTicket.OutrightBetTicketV1 memory bytesTicket) = ticketsV1.tryGet(transIds[i]);

            if (isExist) {
                (bool isSuccess, bytes memory response) = versionEngineMap[bytesTicket.version].call(
                    abi.encodeWithSignature(
                        "rejectBet(bytes)",
                        bytesTicket.signedTicketBytes
                    )
                );

                if (isSuccess) {
                    Settlement.ERC20PaymentV1[] memory payments = abi.decode(
                        response,
                        (Settlement.ERC20PaymentV1[])
                    );

                    for (uint8 j; j < payments.length; j++) {
                        Settlement.ERC20PaymentV1 memory payment = payments[j];
                        require(IERC20(payment.token).transfer(payment.receiver, payment.amount), "CustomerErrors: token transfer error");
                    }

                    ticketsV1.remove(transIds[i]);
                } else {
                    // extract message from engine error memory, and revert the transaction with this message
                    assembly {
                        revert(add(response, 32), mload(response))
                    }
                }
            }
        }
    }

    function pause()
        external
        override
        onlyOwner
    {
        // pause placebet function
        _pause();
    }

    function unpause()
        external
        override
        onlyOwner
    {
        // unpause placebet function
        _unpause();
    }

    function setRejecter(address newRejecter)
        external
        override
        onlyOwner
    {
        rejecter = newRejecter;
    }

    function setTicketEngine(
        uint256 version,
        address engineAddress 
    )
        external
        override
        onlyOwner
    {
        versionEngineMap[version] = engineAddress;
    }

    function setSigner(address newSigner)
        external
        override
        onlyOwner
    {
        signer = newSigner;
    }

    function setSettler(address newSettler)
        external
        override
        onlyOwner
    {
        settler = newSettler;
    }

    function setOracle(address newOracle)
        external
        override
        onlyOwner
    {
        oracle = newOracle;
    }

    function getNonce(address customer)
        external
        view
        override
        returns (uint)
    {
        // get nonce by user account, nonce will be increase after placebet
        return nonces[customer].current();
    }

    function getBet(uint256 transId)
        external
        view
        override
        returns (BytesTicket.OutrightBetTicketV1 memory)
    {
        // get get function for player or payout wallet customer service departmanet
        (, BytesTicket.OutrightBetTicketV1 memory ticket) = ticketsV1.tryGet(transId);
        return ticket;
    }

    function getTicketEngine(uint256 version)
        external
        view
        override
        returns (address)
    {
        // check and debug usage
        return versionEngineMap[version];
    }

    function getRejecter()
        external
        view
        override
        returns (address)
    {
        // check and debug usage
        return rejecter;
    }

    function getSigner()
        external
        view
        override
        returns (address)
    {
        // check and debug usage
        return signer;
    }

    function getSettler()
        external
        view
        override
        returns (address)
    {
        // check and debug usage
        return settler;
    }

    function getOracle()
        external
        view
        override
        returns (address)
    {
        // check and debug usage
        return oracle;
    }

    function getTicketCount()
        external
        view
        override
        returns (uint256)
    {
        // check running ticket count on chain
        return ticketsV1.length();
    }
}
