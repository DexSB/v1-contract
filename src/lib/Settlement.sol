// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/Status.sol";

library Settlement {
    struct SettlementV1 {
        uint256 transId;
        address customer;
        address token;
        uint256 amountToCustomer;
        Status.TicketStatus status;
        ERC20PaymentV1[] payments;
    }

    struct ERC20PaymentV1 {
        address token;
        address receiver;
        uint256 amount;
    }
}
