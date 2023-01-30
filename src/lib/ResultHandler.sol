// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/BetType.sol";
import "src/lib/SportType.sol";
import "forge-std/console.sol";

library ResultHandler {
    function getTicketResult(
        uint256 homeScore,
        uint256 awayScore,
        uint16 sportType,
        uint16 betType,
        uint256 liveHomeScore,
        uint256 liveAwayScore,
        uint hdp1,
        uint hdp2,
        uint256 hdpFactor
    ) internal pure returns (int256) {
        if (
            (betType == BetType.FTHandicap || betType == BetType.HTHandicap) &&
            sportType == SportType.Soccer
        ) {
            homeScore -= liveHomeScore;
            awayScore -= liveAwayScore;
        }

        homeScore *= hdpFactor;
        awayScore *= hdpFactor;

        if (
            betType == BetType.FTHandicap ||
            betType == BetType.HTHandicap ||
            betType == BetType.FTGameHandicap ||
            betType == BetType.QuarterHandicap
        ) {
            return calcHandicap(homeScore, awayScore, hdp1, hdp2);
        } else if (
            betType == BetType.FTOddEven ||
            betType == BetType.HTOddEven ||
            betType == BetType.QuarterOddEven
        ) {
            return calcOddEven(homeScore, awayScore);
        } else if (
            betType == BetType.FTOverUnder ||
            betType == BetType.HTOverUnder ||
            betType == BetType.QuarterOverUnder
        ) {
            return calcOverUnder(homeScore, awayScore, hdp1);
        } else if (
            betType == BetType.FT1x2 ||
            betType == BetType.HT1x2 ||
            betType == BetType.FTMoneyline ||
            betType == BetType.HTMoneyline ||
            betType == BetType.QuarterMoneyline
        ) {
            return calcMoneyLine(homeScore, awayScore);
        }
        return 0;
    }

    function calcHandicap(
        uint256 homeScore,
        uint256 awayScore,
        uint256 hdp1,
        uint256 hdp2
    ) internal pure returns (int256) {
        return
            (int256(homeScore) - int256(hdp1)) -
            (int256(awayScore) - int256(hdp2));
    }

    function calcOddEven(
        uint256 homeScore,
        uint256 awayScore
    ) internal pure returns (int256) {
        return int256(homeScore + awayScore);
    }

    function calcOverUnder(
        uint256 homeScore,
        uint256 awayScore,
        uint256 hdp1
    ) internal pure returns (int256) {
        return int256(homeScore) + int256(awayScore) - int256(hdp1);
    }

    function calcMoneyLine(
        uint256 homeScore,
        uint256 awayScore
    ) internal pure returns (int256) {
        return int256(homeScore) - int256(awayScore);
    }
}
