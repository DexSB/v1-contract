// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/Status.sol";
import "src/lib/BetType.sol";

library SettlePatternHandler {
    
    enum SettlePattern {
        Undefined, // = 0
        Refund, // = 1
        Score, // = 2
        ResultHash // = 3
    }

    // notice: it should order by the game period sequences
    // e.g. there are 4 sets in a match, the ordering will be
    // set1, quarter1, set2, quarter2, half time... etc
    enum BetTypeCategory {
        Undefined, // = 0
        Quarter1, // = 1
        Quarter2, // = 2
        HalfTime, // = 3
        Quarter3, // = 4
        Quarter4, // = 5
        FullTime // = 6
    }

    function getSettlePattern(
        uint16 betType,
        Status.ResultStatus status,
        uint8 resource1
    ) internal pure returns (SettlePattern) {
	// check ticket target period is refund or not
        bool isRefund = getIsRefund(betType, status, resource1);
        if (isRefund) {
	    // if is refund, ticket should run the refund pattern to settle
            return SettlePattern.Refund;
        }
        // betType 413 == correct score
        else if (betType == BetType.FTCorrectScore) {
            // RsultHash is those bet type should settle by key comparasion only
            return SettlePattern.ResultHash;
        }
        else {
            // for those bet type require any ticket result calculation
            return SettlePattern.Score;
        }
    }

    function getIsRefund(
        uint16 betType,
        Status.ResultStatus status,
        uint8 resource1
    ) internal pure returns (bool) {
        // these ResultStatus should refund all tickets
        if (
            status == Status.ResultStatus.Refund ||
            status == Status.ResultStatus.Abandoned1H ||
            status == Status.ResultStatus.AbandonedQ1
        )
        {
            return true;
        }

        // get the ticket target period 
        BetTypeCategory betTypeCategory = getBetTypeCategory(betType, resource1);
        // check if the target period should be refund
        if (status == Status.ResultStatus.Abandoned2H) {
            return betTypeCategory > BetTypeCategory.HalfTime;
        } else if (status == Status.ResultStatus.AbandonedQ2) {
            return betTypeCategory > BetTypeCategory.Quarter1;
        } else if (status == Status.ResultStatus.AbandonedQ3) {
            return betTypeCategory > BetTypeCategory.HalfTime;
        } else if (status == Status.ResultStatus.AbandonedQ4) {
            return betTypeCategory > BetTypeCategory.Quarter3;
        }

        return false;
    }

    function getBetTypeCategory(
        uint16 betType,
        uint8 resource1
    ) internal pure returns (BetTypeCategory) {
        
        if (
            betType == BetType.FTHandicap ||
            betType == BetType.FTOddEven ||
            betType == BetType.FTOverUnder ||
            betType == BetType.FT1x2 ||
            betType == BetType.FTMoneyline ||
            betType == BetType.FTGameHandicap ||
            betType == BetType.FTCorrectScore
        )
        {
            return BetTypeCategory.FullTime;
        } else if (
            betType == BetType.HTHandicap ||
            betType == BetType.HTOverUnder ||
            betType == BetType.HTOddEven ||
            betType == BetType.HT1x2 ||
            betType == BetType.HTMoneyline
        )
        {
            return BetTypeCategory.HalfTime;
        } else if (
            betType == BetType.QuarterHandicap ||
            betType == BetType.QuarterOverUnder ||
            betType == BetType.QuarterOddEven ||
            betType == BetType.QuarterMoneyline
        )
        {
            if (resource1 == 1) {
                return BetTypeCategory.Quarter1;
            } else if (resource1 == 2) {
                return BetTypeCategory.Quarter2;
            } else if (resource1 == 3) {
                return BetTypeCategory.Quarter3;
            } else if (resource1 == 4) {
                return BetTypeCategory.Quarter4;
            }
        }

        revert("CustomErrors: this bet type is not supported yet");
    }
}
