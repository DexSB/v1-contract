// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/oracle/BytesResult.sol";
import "src/lib/oracle/EventResultV1.sol";
import "src/lib/Status.sol";

library TestType {
    uint256 constant FullTime = 1;
    uint256 constant HalfTime = 2;
    uint256 constant OverTime = 3;
    uint256 constant Quarter = 4;
}

library EventResultFactoryV1 {
    function createDefaultEventResult()
        internal
        pure
        returns (EventResultV1.Event memory)
    {
        EventResultV1.Score[] memory sessions = new EventResultV1.Score[](4);
        return EventResultV1.Event(
            1, 1, 1, Status.ResultStatus.Completed,
            EventResultV1.Score(1, 1), EventResultV1.Score(1, 1),
            EventResultV1.Score(1, 1), sessions 
        );
    }

    function createTestEventResult(
        uint256 testType,
        uint256 homeScore,
        uint256 awayScore,
        uint8 resource1
    )
        internal
        pure
        returns (EventResultV1.Event memory)
    {
        EventResultV1.Score[] memory sessions = new EventResultV1.Score[](4);
        if (testType == TestType.Quarter) {
            sessions[resource1 - 1] = EventResultV1.Score(homeScore, awayScore);
        }
        return EventResultV1.Event(
            1, 1, 1, Status.ResultStatus.Completed,
            testType == TestType.FullTime ? EventResultV1.Score(homeScore, awayScore) : EventResultV1.Score(0, 0),
            testType == TestType.HalfTime ? EventResultV1.Score(homeScore, awayScore) : EventResultV1.Score(0, 0),
            testType == TestType.OverTime ? EventResultV1.Score(homeScore, awayScore) : EventResultV1.Score(0, 0),
            sessions 
        );
    }
}
