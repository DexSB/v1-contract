// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/Status.sol";
import "src/lib/Type.sol";

library OutrightBetTicketV1 {
    struct SourceOutrightBet {
        uint256 transId;
        uint256 leagueId;
        uint256 teamId;
        Type.OddsType oddsType;
        int256 displayPrice;
        uint256 displayStake;
        address customer;
        address payoutAddress;
        address token;
        Status.TicketStatus status;
        uint256 deadlineBlock;
    }

    struct OutrightBet {
        uint256 transId;
        uint256 leagueId;
        uint256 teamId;
        uint256 payout;
        uint256 stake;
        address customer;
        address payoutAddress;
        address token;
        Status.TicketStatus status;
        uint256 deadlineBlock;
    }
}
