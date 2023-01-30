// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/oracle/OutrightResultV1.sol";

library OutrightHandlerV1 {
    function getOutrightResult(
        uint256 teamId,
        bytes memory resultBytes
    ) internal pure returns (Status.OutrightTeamStatus, uint256) {
        OutrightResultV1.OutrightEvent memory result = abi.decode(
            resultBytes,
            (OutrightResultV1.OutrightEvent)
        );

        for (uint256 i; i < result.outrights.length; i++) {
            if (teamId == result.outrights[i].teamId) {
                return (result.outrights[i].status, result.deadHeat);
            }
        }
        return (Status.OutrightTeamStatus.Lost, result.deadHeat);
    }

    function getLeagueId(
        bytes memory resultBytes
    ) internal pure returns (uint256) {
        OutrightResultV1.OutrightEvent memory result = abi.decode(
            resultBytes,
            (OutrightResultV1.OutrightEvent)
        );

        return result.leagueId;
    }
}
