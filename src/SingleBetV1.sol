// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-contracts/contracts/utils/Counters.sol";
import "src/interface/ISingleBetV1.sol";
import "src/lib/single/BytesTicketMap.sol";
import "src/lib/Receipt.sol";
import "src/lib/Settlement.sol";
import "src/utils/BaseOwnablePausable.sol";

contract SingleBetV1 is BaseOwnablePausable, ISingleBetV1 {
    using Counters for Counters.Counter;
    using BytesTicketMap for BytesTicketMap.SingleBetTicketMapV1;

    address signer;
    address settler;
    address rejecter;
    address oracle;

    mapping(address => Counters.Counter) nonces;
    mapping(uint256 => address) versionEngineMap;

    BytesTicketMap.SingleBetTicketMapV1 ticketsV1;

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
        uint256 eventId,
        uint256[] calldata transIds
    ) external override {
        // this function must be called by settler account
        require(
            msg.sender == settler,
            "CustomErrors: caller is not the settler"
        );

        for (uint256 i; i < transIds.length; i++) {
            // try get ticket from storage
            (
                bool isExist,
                BytesTicket.SingleBetTicketV1 memory ticket
            ) = ticketsV1.tryGet(transIds[i]);

            if (isExist) {
                // settle bet by the engine and it will return the settlement and payments
                (bool isSuccess, bytes memory response) = versionEngineMap[
                    ticket.version
                ].call(
                        abi.encodeWithSignature(
                            "settleBet(uint256,address,bytes)",
                            eventId,
                            oracle,
                            ticket.signedTicketBytes
                        )
                    );
                if (isSuccess) {
                    // decode the response to extract the settlement and payments
                    Settlement.SettlementV1 memory settlement = abi.decode(
                        response,
                        (Settlement.SettlementV1)
                    );

                    // final check of the customer address, it shouldn't be address(0) if everything works fine
                    if (settlement.customer != address(0)) {
                        for (uint8 j; j < settlement.payments.length; j++) {
                            Settlement.ERC20PaymentV1
                                memory payment = settlement.payments[j];
                            require(
                                IERC20(payment.token).transfer(
                                    payment.receiver,
                                    payment.amount
                                ),
                                "CustomerErrors: token transfer error"
                            );
                        }
                        // emit the ticket settlement for the off-chain service to update the database status
                        emit SingleTicketSettled(
                            transIds[i],
                            settlement.customer,
                            settlement.token,
                            settlement.amountToCustomer,
                            settlement.status
                        );
                        // remove ticket from the storage
                        ticketsV1.remove(transIds[i]);
                    } else {
                        emit SingleBetSettlementNull(transIds[i]);
                    }
                } else {
                    // extract message in the engine call memory, and revert it with the message
                    assembly {
                        revert(add(response, 32), mload(response))
                    }
                }
            }
        }
    }

    function placeBet(
        uint256 version,
        bytes calldata signedTicketBytes
    ) external override whenNotPaused {
        // call engine to do the required vilidation and calculation, it'll return the receipt
        (bool isSuccess, bytes memory response) = versionEngineMap[version]
            .call(
                abi.encodeWithSignature(
                    "processTicket(address,uint256,bytes)",
                    signer,
                    nonces[msg.sender].current(),
                    signedTicketBytes
                )
            );

        if (isSuccess) {
            // get the receipt from the engine's response
            (Receipt.BetReceiptV1 memory receipt, bytes memory ticket) = abi
                .decode(response, (Receipt.BetReceiptV1, bytes));

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

            BytesTicket.SingleBetTicketV1 memory bytesTicket = BytesTicket
                .SingleBetTicketV1(version, ticket);
            ticketsV1.set(receipt.transId, bytesTicket);
            // increase user nonce to prevent the duplicate transactoin
            nonces[msg.sender].increment();
            // send event for off-chain service to update the database
            emit SingleBetPlaced(receipt.transId, receipt.customer);
        } else {
            assembly {
                // return error in the engine call memory
                revert(add(response, 32), mload(response))
            }
        }
    }

    function rejectBet(uint256[] calldata transIds) external override {
        // this function must be called by rejecter account
        require(
            msg.sender == rejecter,
            "CustomErrors: caller is not the rejecter"
        );

        for (uint256 i; i < transIds.length; i++) {
            // try get ticket from storage
            (
                bool isExist,
                BytesTicket.SingleBetTicketV1 memory bytesTicket
            ) = ticketsV1.tryGet(transIds[i]);
            if (isExist) {
                // call a specific version of engine to get the payment info of the reject
                (bool isSuccess, bytes memory response) = versionEngineMap[
                    bytesTicket.version
                ].call(
                        abi.encodeWithSignature(
                            "rejectBet(bytes)",
                            bytesTicket.signedTicketBytes
                        )
                    );

                if (isSuccess) {
                    // decode response to payments
                    Settlement.ERC20PaymentV1[] memory payments = abi.decode(
                        response,
                        (Settlement.ERC20PaymentV1[])
                    );

                    for (uint256 j; j < payments.length; j++) {
                        Settlement.ERC20PaymentV1 memory payment = payments[j];
                        require(
                            IERC20(payment.token).transfer(
                                payment.receiver,
                                payment.amount
                            ),
                            "CustomerErrors: token transfer error"
                        );
                    }

                    ticketsV1.remove(transIds[i]);
                } else {
                    assembly {
                        // return error in the engine call memory
                        revert(add(response, 32), mload(response))
                    }
                }
            }
        }
    }

    function setTicketEngine(
        uint256 version,
        address engineAddress
    ) external override onlyOwner {
        // set ticket engine address, notice that you should set it AFTER the engine is uploaded and well tested
        versionEngineMap[version] = engineAddress;
    }

    function setRejecter(address newRejecter) external override onlyOwner {
        // set rejecer account, it MUST match the off-chain system rejecter to guarantee the rejectbet process works
        rejecter = newRejecter;
    }

    function setSigner(address newSigner) external override onlyOwner {
        // set signer account, it MUST match the off-chain system signer to guarantee the placebet process works
        signer = newSigner;
    }

    function setSettler(address newSettler) external override onlyOwner {
        // set settler account, it MUST match the off-chain system settler to guarantee the settlebet process works
        settler = newSettler;
    }

    function setOracle(address newOracle) external override onlyOwner {
        // set oracle address, settle bet will get result from this address
        oracle = newOracle;
    }

    function pause() external override onlyOwner {
        // pause placebet function
        _pause();
    }

    function unpause() external override onlyOwner {
        // unpause placebet function
        _unpause();
    }

    function getNonce(address customer) external view override returns (uint) {
        // get nonce by user account, nonce will be increase after placebet
        return nonces[customer].current();
    }

    function getBet(
        uint256 transId
    ) external view override returns (BytesTicket.SingleBetTicketV1 memory) {
        // get bet function for player or payout wallet customer service department
        (, BytesTicket.SingleBetTicketV1 memory ticket) = ticketsV1.tryGet(
            transId
        );
        return ticket;
    }

    function getTicketEngine(
        uint256 version
    ) external view override returns (address) {
        // check and debug usage
        return versionEngineMap[version];
    }

    function getRejecter() external view override returns (address) {
        // check and debug usage
        return rejecter;
    }

    function getSigner() external view override returns (address) {
        // check and debug usage
        return signer;
    }

    function getSettler() external view override returns (address) {
        // check and debug usage
        return settler;
    }

    function getOracle() external view override returns (address) {
        // check and debug usage
        return oracle;
    }

    function getTicketCount() external view override returns (uint256) {
        // check running ticket count on chain
        return ticketsV1.length();
    }
}
