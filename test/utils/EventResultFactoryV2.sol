// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/oracle/BytesResult.sol";
import "src/lib/oracle/EventResultV2.sol";
import "src/lib/Status.sol";

library TestType {
    uint256 constant FullTime = 1;
    uint256 constant HalfTime = 2;
    uint256 constant OverTime = 3;
    uint256 constant Quarter = 4;
    uint256 constant FTGame = 5;
}

library EventResultFactoryV2 {
    function createDefaultEventResult()
        internal
        pure
        returns (EventResultV2.Event memory)
    {
        EventResultV2.Score[] memory sessions = new EventResultV2.Score[](4);
        return
            EventResultV2.Event(
                1,
                1,
                1,
                Status.ResultStatus.Completed,
                EventResultV2.Score(1, 1),
                EventResultV2.Score(1, 1),
                EventResultV2.Score(1, 1),
                sessions,
                EventResultV2.Score(1, 1)
            );
    }

    function createTestEventResult(
        uint256 testType,
        uint256 homeScore,
        uint256 awayScore,
        uint8 resource1,
        uint256 sportType
    ) internal pure returns (EventResultV2.Event memory) {
        EventResultV2.Score[] memory sessions = new EventResultV2.Score[](4);
        if (testType == TestType.Quarter) {
            sessions[resource1 - 1] = EventResultV2.Score(homeScore, awayScore);
        }
        return
            EventResultV2.Event(
                1,
                1,
                1,
                Status.ResultStatus.Completed,
                testType == TestType.FullTime
                    ? EventResultV2.Score(homeScore, awayScore)
                    : EventResultV2.Score(0, 0),
                testType == TestType.HalfTime
                    ? EventResultV2.Score(homeScore, awayScore)
                    : EventResultV2.Score(0, 0),
                testType == TestType.OverTime
                    ? EventResultV2.Score(homeScore, awayScore)
                    : EventResultV2.Score(0, 0),
                sessions,
                testType == TestType.FTGame
                    ? EventResultV2.Score(homeScore, awayScore)
                    : EventResultV2.Score(0, 0)
            );
    }
}
