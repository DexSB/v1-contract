// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/utils/math/SignedMath.sol";
import "src/lib/Type.sol";

library BettingHandler {

    using SignedMath for int256;

    function getStakeAndPayout(
        Type.OddsType oddsType,
        int256 displayPrice,
        uint256 displayStake,
        uint256 priceFactor
    )
        internal
        pure
        returns (
            uint256 payout,
            uint256 stake
        )
    {
        if (oddsType == Type.OddsType.Decimal) {
            // decimal odds should include player's stake
            payout = (uint256(displayPrice) * displayStake) / priceFactor;
            stake = displayStake;
        } else if (oddsType == Type.OddsType.HongKong) {
            // hong kong odds should return the possible winning only
            uint256 price = uint256(displayPrice) + (1 * priceFactor);
            payout = (price * displayStake) / priceFactor;
            stake = displayStake;
        } else if (oddsType == Type.OddsType.Indo) {
            // indo odds is not supported yet
            payout = 0;
            stake = 0;
        } else if (oddsType == Type.OddsType.Malay) {
            if (displayPrice > 0) {
                // when malay odds is a positive number, the calculation should be the same with hong kong odds
                uint256 price = uint256(displayPrice) + (1 * priceFactor);
                payout = (price * displayStake) / priceFactor;
                stake = displayStake;
            } else {
                // when malay odds is a nagative number, the price is the amount of player will win
                // the actual stake will be stake * price, and the payout should add display stake on the actual stake
                uint256 priceAbs = displayPrice.abs();
                payout = ((priceAbs * displayStake) / priceFactor) + displayStake;
                stake = (priceAbs * displayStake) / priceFactor;
            }
        } else if (oddsType == Type.OddsType.America) {
            // american odds is not supported yet
            payout = 0;
            stake = 0;
        }
    }
}
