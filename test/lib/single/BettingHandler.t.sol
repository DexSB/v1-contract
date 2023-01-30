// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/engine/single/BettingHandler.sol";
import "test/utils/BaseTest.sol";

contract BettingHandlerTest is BaseTest {
    function testDecimalOdds() public {
        uint256 payout;
        uint256 stake;
        {
            (payout, stake) = BettingHandler.getStakeAndPayout(
                Type.OddsType.Decimal,
                300,
                1000000,
                100
            );
            assertEq(payout, 3 * 1000000);
            assertEq(stake, 1 * 1000000);
        }
        {
            (payout, stake) = BettingHandler.getStakeAndPayout(
                Type.OddsType.Decimal,
                191,
                1000000,
                100
            );
            assertEq(payout, 191 * 10000);
            assertEq(stake, 1 * 1000000);
        }
    }

    function testHongKongOdds() public {
        uint256 payout;
        uint256 stake;
        {
            (payout, stake) = BettingHandler.getStakeAndPayout(
                Type.OddsType.HongKong,
                300,
                1000000,
                100
            );
            assertEq(payout, 4 * 1000000);
            assertEq(stake, 1 * 1000000);
        }
        {
            (payout, stake) = BettingHandler.getStakeAndPayout(
                Type.OddsType.HongKong,
                191,
                1000000,
                100
            );
            assertEq(payout, 291 * 10000);
            assertEq(stake, 1 * 1000000);
        }
        {
            (payout, stake) = BettingHandler.getStakeAndPayout(
                Type.OddsType.HongKong,
                92,
                1000000,
                100
            );
            assertEq(payout, 192 * 10000);
            assertEq(stake, 1 * 1000000);
        }
    }

    function testMalayOdds() public {
        uint256 payout;
        uint256 stake;
        {
            (payout, stake) = BettingHandler.getStakeAndPayout(
                Type.OddsType.Malay,
                92,
                1000000,
                100
            );
            assertEq(payout, 192 * 10000);
            assertEq(stake, 1 * 1000000);
        }
        {
            (payout, stake) = BettingHandler.getStakeAndPayout(
                Type.OddsType.Malay,
                -92,
                1000000,
                100
            );
            assertEq(payout, 192 * 10000);
            assertEq(stake, 92 * 10000);
        }
    }
}
