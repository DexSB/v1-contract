// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

library Signature {
    struct Vrs {
        uint8 v;
        bytes32 r;
        bytes32 s;
    }
}
