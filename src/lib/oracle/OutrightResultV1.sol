// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/Status.sol";

library OutrightResultV1 {

    struct OutrightEvent {
        uint16 sportType;
        uint256 leagueId;
        Outright[] outrights;
        uint16 deadHeat;
    }

    struct Outright {
        uint256 teamId;
        Status.OutrightTeamStatus status;
    }
}
