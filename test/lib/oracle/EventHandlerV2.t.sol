// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/oracle/EventHandlerV2.sol";
import "test/utils/BaseTest.sol";
import "test/utils/EventResultFactoryV2.sol";
import "src/lib/SportType.sol";

contract EventHandlerV2Test is BaseTest {
    uint256 targetHomeScore = 3;
    uint256 targetAwayScore = 5;

    function testGetSoccerFullTimeScore() public {
        uint256 homeScore = 0;
        uint256 awayScore = 0;

        EventResultV2.Event memory result = EventResultFactoryV2
            .createTestEventResult(
                TestType.FullTime,
                targetHomeScore,
                targetAwayScore,
                0,
                SportType.Soccer
            );

        (homeScore, awayScore) = EventHandlerV2.getScore(
            SportType.Soccer,
            BetType.FTHandicap,
            0,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);

        (homeScore, awayScore) = EventHandlerV2.getScore(
            SportType.Soccer,
            BetType.FTOddEven,
            0,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);

        (homeScore, awayScore) = EventHandlerV2.getScore(
            SportType.Soccer,
            BetType.FTOverUnder,
            0,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);

        (homeScore, awayScore) = EventHandlerV2.getScore(
            SportType.Soccer,
            BetType.FT1x2,
            0,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);

        (homeScore, awayScore) = EventHandlerV2.getScore(
            SportType.Soccer,
            BetType.FTMoneyline,
            0,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);

        (homeScore, awayScore) = EventHandlerV2.getScore(
            SportType.Soccer,
            BetType.FTCorrectScore,
            0,
            abi.encode(result)
        );

        assertEq(targetHomeScore, homeScore);
        assertEq(targetAwayScore, awayScore);
    }

    function testGetTennisFullTimeScore() public {
        uint256 homeScore = 0;
        uint256 awayScore = 0;

        {
            EventResultV2.Event memory result = EventResultFactoryV2
                .createTestEventResult(
                    TestType.FullTime,
                    targetHomeScore,
                    targetAwayScore,
                    0,
                    SportType.Tennis
                );

            (homeScore, awayScore) = EventHandlerV2.getScore(
                SportType.Tennis,
                BetType.FTHandicap,
                0,
                abi.encode(result)
            );

            assertEq(targetHomeScore, homeScore);
            assertEq(targetAwayScore, awayScore);

            (homeScore, awayScore) = EventHandlerV2.getScore(
                SportType.Tennis,
                BetType.FTMoneyline,
                0,
                abi.encode(result)
            );

            assertEq(targetHomeScore, homeScore);
            assertEq(targetAwayScore, awayScore);
        }

        {
            EventResultV2.Event memory result = EventResultFactoryV2
                .createTestEventResult(
                    TestType.FTGame,
                    targetHomeScore,
                    targetAwayScore,
                    0,
                    SportType.Tennis
                );

            (homeScore, awayScore) = EventHandlerV2.getScore(
                SportType.Tennis,
                BetType.FTGameHandicap,
                0,
                abi.encode(result)
            );

            assertEq(targetHomeScore, homeScore);
            assertEq(targetAwayScore, awayScore);

            (homeScore, awayScore) = EventHandlerV2.getScore(
                SportType.Tennis,
                BetType.FTOddEven,
                0,
                abi.encode(result)
            );

            assertEq(targetHomeScore, homeScore);
            assertEq(targetAwayScore, awayScore);

            (homeScore, awayScore) = EventHandlerV2.getScore(
                SportType.Tennis,
                BetType.FTOverUnder,
                0,
                abi.encode(result)
            );

            assertEq(targetHomeScore, homeScore);
            assertEq(targetAwayScore, awayScore);
        }
    }
}
