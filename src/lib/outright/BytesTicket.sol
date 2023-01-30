// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

library BytesTicket {

    struct OutrightBetTicketV1 {
        uint256 version;
        bytes signedTicketBytes;
    }
}
