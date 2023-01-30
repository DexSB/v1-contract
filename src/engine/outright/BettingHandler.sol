// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/utils/math/SignedMath.sol";
import "src/lib/outright/OutrightBetTicketV1.sol";

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
            payout = (uint256(displayPrice) * displayStake) / priceFactor;
            stake = displayStake;
        } else if (oddsType == Type.OddsType.HongKong) {
            uint256 price = uint256(displayPrice) + (1 * priceFactor);
            payout = (price * displayStake) / priceFactor;
            stake = displayStake;
        } else if (oddsType == Type.OddsType.Indo) {
            payout = 0;
            stake = 0;
        } else if (oddsType == Type.OddsType.Malay) {
            if (displayPrice > 0) {
                uint256 price = uint256(displayPrice) + (1 * priceFactor);
                payout = (price * displayStake) / priceFactor;
                stake = displayStake;
            } else {
                uint256 priceAbs = displayPrice.abs();
                payout = ((priceAbs * displayStake) / priceFactor) + displayStake;
                stake = (priceAbs * displayStake) / priceFactor;
            }
        } else if (oddsType == Type.OddsType.America) {
            payout = 0;
            stake = 0;
        }
    }
}
