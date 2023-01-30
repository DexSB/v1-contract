// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/Status.sol";
import "src/lib/Type.sol";

library SingleBetTicketV1 {
    struct SourceSingleBet {
        uint256 transId;
        uint16 sportType;
        uint256 eventId;
        uint16 betType;
        string key;
        uint liveHomeScore;
        uint liveAwayScore;
        Type.OddsType oddsType;
        int256 displayPrice;
        uint256 displayStake;
        address customer;
        address payoutAddress;
        address token;
        uint hdp1;
        uint hdp2;
        uint8 resource1;
        Status.TicketStatus status;
        uint256 deadlineBlock;
    }

    struct SingleBet {
        uint256 transId;
        uint16 sportType;
        uint256 eventId;
        uint16 betType;
        bytes32 keyHash;
        uint liveHomeScore;
        uint liveAwayScore;
        Type.OddsType oddsType;
        uint256 payout;
        uint256 stake;
        address customer;
        address payoutAddress;
        address token;
        uint hdp1;
        uint hdp2;
        uint8 resource1;
        Status.TicketStatus status;
        uint256 deadlineBlock;
    }
}
