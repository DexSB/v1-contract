// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

library Status {
    enum OutrightTeamStatus {
        Undefined, // = 0
        Won, // = 1
        Lost, // = 2
        Refund // = 3
    }

    enum ResultStatus {
        Undefined, // = 0
        Completed, // = 1
        Refund, // = 2
        Abandoned1H, // = 3
        Abandoned2H, // = 4
        AbandonedQ1, // = 5
        AbandonedQ2, // = 6
        AbandonedQ3, // = 7
        AbandonedQ4 // = 8
    }

    enum TicketStatus {
        Undefined, // = 0
        Waiting, // = 1
        Running, // = 2
        Rejected, // = 3
        Canceled, // = 4
        Refund, // = 5
        Void, // = 6
        Won, // = 7
        HalfWon, // = 8
        Draw, // = 9
        Lost, // = 10
        HalfLost // = 11
    }
}
