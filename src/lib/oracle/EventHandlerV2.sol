// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/utils/Strings.sol";
import "src/lib/oracle/EventResultV2.sol";
import "src/lib/Status.sol";
import "src/lib/BetType.sol";
import "src/lib/SportType.sol";

library EventHandlerV2 {
    function getScore(
        uint256 sportType,
        uint16 betType,
        uint8 resource1,
        bytes memory resultBytes
    ) internal pure returns (uint256 homeScore, uint256 awayScore) {
        EventResultV2.Event memory result = abi.decode(
            resultBytes,
            (EventResultV2.Event)
        );

        if (
            betType == BetType.FTHandicap ||
            betType == BetType.FTOddEven ||
            betType == BetType.FTOverUnder ||
            betType == BetType.FT1x2 ||
            betType == BetType.FTMoneyline ||
            betType == BetType.FTCorrectScore ||
            betType == BetType.FTGameHandicap
        )
        {
            if (sportType == SportType.Tennis) {
                if (
                    betType == BetType.FTGameHandicap ||
                    betType == BetType.FTOddEven || 
                    betType == BetType.FTOverUnder
                ) {
                    homeScore = uint256(result.gameScore.homeScore);
                    awayScore = uint256(result.gameScore.awayScore);
                    return (homeScore, awayScore);
                }
            }

            homeScore = uint256(result.fullTimeScore.homeScore);
            awayScore = uint256(result.fullTimeScore.awayScore);
            return (homeScore, awayScore);
        } 

        if (
            betType == BetType.HTHandicap ||
            betType == BetType.HTOverUnder ||
            betType == BetType.HTOddEven ||
            betType == BetType.HT1x2 ||
            betType == BetType.HTMoneyline
        )
        {
            homeScore = uint256(result.halfTimeScore.homeScore);
            awayScore = uint256(result.halfTimeScore.awayScore);
            return (homeScore, awayScore);
        } 

        if (
            betType == BetType.QuarterHandicap ||
            betType == BetType.QuarterOverUnder ||
            betType == BetType.QuarterOddEven ||
            betType == BetType.QuarterMoneyline
        )
        {
            homeScore = uint256(result.sessionScores[resource1 - 1].homeScore);
            awayScore = uint256(result.sessionScores[resource1 - 1].awayScore);
            return (homeScore, awayScore);
        }
    }

    function getEventStatus(
        bytes memory resultBytes
    ) internal pure returns (Status.ResultStatus) {
        EventResultV2.Event memory result = abi.decode(
            resultBytes,
            (EventResultV2.Event)
        );
        return result.status;
    }

    function getResultHash(
        uint256 sportType,
        uint16 betType,
        uint8 resource1,
        bytes memory resultBytes
    ) internal pure returns (bytes32) {
        (uint256 homeScore, uint256 awayScore) = getScore(sportType, betType, resource1, resultBytes);
        return keccak256(abi.encode(abi.encodePacked(
            Strings.toString(homeScore),
            ":",
            Strings.toString(awayScore)))
        );
    }

    function getEventId(
        bytes memory resultBytes
    ) internal pure returns (uint256) {
        EventResultV2.Event memory result = abi.decode(
            resultBytes,
            (EventResultV2.Event)
        );

        return result.eventId;
    }
}
