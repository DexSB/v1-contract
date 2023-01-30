// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/Status.sol";

library EventResultV1 {

    struct Event {
        uint256 eventId;
        uint256 homeId;
        uint256 awayId;
        Status.ResultStatus status;
        Score fullTimeScore;
        Score halfTimeScore;
        Score overTimeScore;
        Score[] sessionScores;
    }

    struct Score {
        uint256 homeScore;
        uint256 awayScore;
    }
}
