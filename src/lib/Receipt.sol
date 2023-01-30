// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

library Receipt {
    struct BetReceiptV1 {
        uint256 transId;
        address customer;
        TokenClaimDto[] tokenClaimDtos;
    }

    struct TokenClaimDto {
        address account;
        address token;
        uint256 amount;
    }
}
