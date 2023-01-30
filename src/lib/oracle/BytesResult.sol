// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

library BytesResult {
    struct EventResultV1 {
        uint256 version;
        bytes resultBytes;
    }

    struct OutrightResultV1 {
        uint256 version;
        bytes resultBytes;
    }
}
