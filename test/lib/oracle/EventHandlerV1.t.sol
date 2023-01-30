// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/oracle/EventHandlerV1.sol";
import "test/utils/BaseTest.sol";
import "test/utils/EventResultFactoryV1.sol";

contract EventHandlerV1Test is BaseTest {
    uint256 targetHomeScore = 3;
    uint256 targetAwayScore = 5;

    function testGetFullTimeScore() public {
        uint256 homeScore = 0;
        uint256 awayScore = 0;

        EventResultV1.Event memory result = 
            EventResultFactoryV1.createTestEventResult(
                TestType.FullTime,
                targetHomeScore,
                targetAwayScore,
                0
            );
        
        (homeScore, awayScore) = EventHandlerV1.getScore(
            BetType.FTHandicap,
            0,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);

        (homeScore, awayScore) = EventHandlerV1.getScore(
            BetType.FTOddEven,
            0,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);

        (homeScore, awayScore) = EventHandlerV1.getScore(
            BetType.FTOverUnder,
            0,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);

        (homeScore, awayScore) = EventHandlerV1.getScore(
            BetType.FT1x2,
            0,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);

        (homeScore, awayScore) = EventHandlerV1.getScore(
            BetType.FTMoneyline,
            0,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);

        (homeScore, awayScore) = EventHandlerV1.getScore(
            BetType.FTCorrectScore,
            0,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);
    }

    function testGetHalfTimeScore() public {
        uint256 homeScore = 0;
        uint256 awayScore = 0;

        EventResultV1.Event memory result = 
            EventResultFactoryV1.createTestEventResult(
                TestType.HalfTime,
                targetHomeScore,
                targetAwayScore,
                0
            );

        (homeScore, awayScore) = EventHandlerV1.getScore(
            BetType.HTHandicap,
            0,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);

        (homeScore, awayScore) = EventHandlerV1.getScore(
            BetType.HTOverUnder,
            0,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);

        (homeScore, awayScore) = EventHandlerV1.getScore(
            BetType.HTOddEven,
            0,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);

        (homeScore, awayScore) = EventHandlerV1.getScore(
            BetType.HT1x2,
            0,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);

        (homeScore, awayScore) = EventHandlerV1.getScore(
            BetType.HTMoneyline,
            0,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);
    }
  
    function testGetQuarterScore() public {
        uint256 homeScore = 0;
        uint256 awayScore = 0;

        EventResultV1.Event memory result = 
            EventResultFactoryV1.createTestEventResult(
                TestType.Quarter,
                targetHomeScore,
                targetAwayScore,
                1
            );

        (homeScore, awayScore) = EventHandlerV1.getScore(
            BetType.QuarterHandicap,
            1,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);

        (homeScore, awayScore) = EventHandlerV1.getScore(
            BetType.QuarterOverUnder,
            1,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);

        (homeScore, awayScore) = EventHandlerV1.getScore(
            BetType.QuarterOddEven,
            1,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);

        (homeScore, awayScore) = EventHandlerV1.getScore(
            BetType.QuarterMoneyline,
            1,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);
    }
}
