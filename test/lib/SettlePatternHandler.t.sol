// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "test/utils/BaseTest.sol";
import "src/lib/SettlePatternHandler.sol";

contract SettlePatternHandlerTest is BaseTest {
    function testGetIsRefund() public {
        {
            assertTrue(SettlePatternHandler.getIsRefund(1, Status.ResultStatus.Refund, 0));
            assertTrue(SettlePatternHandler.getIsRefund(2, Status.ResultStatus.Refund, 0));
            assertTrue(SettlePatternHandler.getIsRefund(3, Status.ResultStatus.Refund, 0));
            assertTrue(SettlePatternHandler.getIsRefund(5, Status.ResultStatus.Refund, 0));
            assertTrue(SettlePatternHandler.getIsRefund(7, Status.ResultStatus.Refund, 0));
            assertTrue(SettlePatternHandler.getIsRefund(8, Status.ResultStatus.Refund, 0));
            assertTrue(SettlePatternHandler.getIsRefund(12, Status.ResultStatus.Refund, 0));
            assertTrue(SettlePatternHandler.getIsRefund(15, Status.ResultStatus.Refund, 0));
            assertTrue(SettlePatternHandler.getIsRefund(20, Status.ResultStatus.Refund, 0));
            assertTrue(SettlePatternHandler.getIsRefund(21, Status.ResultStatus.Refund, 0));
            assertTrue(SettlePatternHandler.getIsRefund(413, Status.ResultStatus.Refund, 0));
            assertTrue(SettlePatternHandler.getIsRefund(609, Status.ResultStatus.Refund, 4));
            assertTrue(SettlePatternHandler.getIsRefund(610, Status.ResultStatus.Refund, 4));
            assertTrue(SettlePatternHandler.getIsRefund(611, Status.ResultStatus.Refund, 4));
            assertTrue(SettlePatternHandler.getIsRefund(612, Status.ResultStatus.Refund, 4));
        }
        {
            assertTrue(SettlePatternHandler.getIsRefund(1, Status.ResultStatus.Abandoned1H, 0));
            assertTrue(SettlePatternHandler.getIsRefund(2, Status.ResultStatus.Abandoned1H, 0));
            assertTrue(SettlePatternHandler.getIsRefund(3, Status.ResultStatus.Abandoned1H, 0));
            assertTrue(SettlePatternHandler.getIsRefund(5, Status.ResultStatus.Abandoned1H, 0));
            assertTrue(SettlePatternHandler.getIsRefund(7, Status.ResultStatus.Abandoned1H, 0));
            assertTrue(SettlePatternHandler.getIsRefund(8, Status.ResultStatus.Abandoned1H, 0));
            assertTrue(SettlePatternHandler.getIsRefund(12, Status.ResultStatus.Abandoned1H, 0));
            assertTrue(SettlePatternHandler.getIsRefund(15, Status.ResultStatus.Abandoned1H, 0));
            assertTrue(SettlePatternHandler.getIsRefund(20, Status.ResultStatus.Abandoned1H, 0));
            assertTrue(SettlePatternHandler.getIsRefund(21, Status.ResultStatus.Abandoned1H, 0));
            assertTrue(SettlePatternHandler.getIsRefund(413, Status.ResultStatus.Abandoned1H, 0));
            assertTrue(SettlePatternHandler.getIsRefund(609, Status.ResultStatus.Abandoned1H, 4));
            assertTrue(SettlePatternHandler.getIsRefund(610, Status.ResultStatus.Abandoned1H, 4));
            assertTrue(SettlePatternHandler.getIsRefund(611, Status.ResultStatus.Abandoned1H, 4));
            assertTrue(SettlePatternHandler.getIsRefund(612, Status.ResultStatus.Abandoned1H, 4));
        }
        {
            assertTrue(SettlePatternHandler.getIsRefund(1, Status.ResultStatus.AbandonedQ1, 0));
            assertTrue(SettlePatternHandler.getIsRefund(2, Status.ResultStatus.AbandonedQ1, 0));
            assertTrue(SettlePatternHandler.getIsRefund(3, Status.ResultStatus.AbandonedQ1, 0));
            assertTrue(SettlePatternHandler.getIsRefund(5, Status.ResultStatus.AbandonedQ1, 0));
            assertTrue(SettlePatternHandler.getIsRefund(7, Status.ResultStatus.AbandonedQ1, 0));
            assertTrue(SettlePatternHandler.getIsRefund(8, Status.ResultStatus.AbandonedQ1, 0));
            assertTrue(SettlePatternHandler.getIsRefund(12, Status.ResultStatus.AbandonedQ1, 0));
            assertTrue(SettlePatternHandler.getIsRefund(15, Status.ResultStatus.AbandonedQ1, 0));
            assertTrue(SettlePatternHandler.getIsRefund(20, Status.ResultStatus.AbandonedQ1, 0));
            assertTrue(SettlePatternHandler.getIsRefund(21, Status.ResultStatus.AbandonedQ1, 0));
            assertTrue(SettlePatternHandler.getIsRefund(413, Status.ResultStatus.AbandonedQ1, 0));
            assertTrue(SettlePatternHandler.getIsRefund(609, Status.ResultStatus.AbandonedQ1, 4));
            assertTrue(SettlePatternHandler.getIsRefund(610, Status.ResultStatus.AbandonedQ1, 4));
            assertTrue(SettlePatternHandler.getIsRefund(611, Status.ResultStatus.AbandonedQ1, 4));
            assertTrue(SettlePatternHandler.getIsRefund(612, Status.ResultStatus.AbandonedQ1, 4));
        }
        {
            assertTrue(SettlePatternHandler.getIsRefund(1, Status.ResultStatus.Abandoned2H, 0));
            assertTrue(SettlePatternHandler.getIsRefund(2, Status.ResultStatus.Abandoned2H, 0));
            assertTrue(SettlePatternHandler.getIsRefund(3, Status.ResultStatus.Abandoned2H, 0));
            assertTrue(SettlePatternHandler.getIsRefund(5, Status.ResultStatus.Abandoned2H, 0));
            assertTrue(SettlePatternHandler.getIsRefund(20, Status.ResultStatus.Abandoned2H, 0));
            assertTrue(!SettlePatternHandler.getIsRefund(609, Status.ResultStatus.Abandoned2H, 1));
            assertTrue(!SettlePatternHandler.getIsRefund(610, Status.ResultStatus.Abandoned2H, 1));
            assertTrue(!SettlePatternHandler.getIsRefund(611, Status.ResultStatus.Abandoned2H, 1));
            assertTrue(!SettlePatternHandler.getIsRefund(612, Status.ResultStatus.Abandoned2H, 1));
            assertTrue(!SettlePatternHandler.getIsRefund(609, Status.ResultStatus.Abandoned2H, 2));
            assertTrue(!SettlePatternHandler.getIsRefund(610, Status.ResultStatus.Abandoned2H, 2));
            assertTrue(!SettlePatternHandler.getIsRefund(611, Status.ResultStatus.Abandoned2H, 2));
            assertTrue(!SettlePatternHandler.getIsRefund(612, Status.ResultStatus.Abandoned2H, 2));
            assertTrue(SettlePatternHandler.getIsRefund(609, Status.ResultStatus.Abandoned2H, 3));
            assertTrue(SettlePatternHandler.getIsRefund(610, Status.ResultStatus.Abandoned2H, 3));
            assertTrue(SettlePatternHandler.getIsRefund(611, Status.ResultStatus.Abandoned2H, 3));
            assertTrue(SettlePatternHandler.getIsRefund(612, Status.ResultStatus.Abandoned2H, 3));
            assertTrue(SettlePatternHandler.getIsRefund(609, Status.ResultStatus.Abandoned2H, 4));
            assertTrue(SettlePatternHandler.getIsRefund(610, Status.ResultStatus.Abandoned2H, 4));
            assertTrue(SettlePatternHandler.getIsRefund(611, Status.ResultStatus.Abandoned2H, 4));
            assertTrue(SettlePatternHandler.getIsRefund(612, Status.ResultStatus.Abandoned2H, 4));
            assertTrue(!SettlePatternHandler.getIsRefund(7, Status.ResultStatus.Abandoned2H, 0));
            assertTrue(!SettlePatternHandler.getIsRefund(8, Status.ResultStatus.Abandoned2H, 0));
            assertTrue(!SettlePatternHandler.getIsRefund(12, Status.ResultStatus.Abandoned2H, 0));
            assertTrue(!SettlePatternHandler.getIsRefund(15, Status.ResultStatus.Abandoned2H, 0));
            assertTrue(!SettlePatternHandler.getIsRefund(21, Status.ResultStatus.Abandoned2H, 0));
            assertTrue(SettlePatternHandler.getIsRefund(609, Status.ResultStatus.Abandoned2H, 3));
            assertTrue(SettlePatternHandler.getIsRefund(610, Status.ResultStatus.Abandoned2H, 3));
            assertTrue(SettlePatternHandler.getIsRefund(611, Status.ResultStatus.Abandoned2H, 3));
            assertTrue(SettlePatternHandler.getIsRefund(612, Status.ResultStatus.Abandoned2H, 3));
            assertTrue(SettlePatternHandler.getIsRefund(609, Status.ResultStatus.Abandoned2H, 4));
            assertTrue(SettlePatternHandler.getIsRefund(610, Status.ResultStatus.Abandoned2H, 4));
            assertTrue(SettlePatternHandler.getIsRefund(611, Status.ResultStatus.Abandoned2H, 4));
            assertTrue(SettlePatternHandler.getIsRefund(612, Status.ResultStatus.Abandoned2H, 4));
        }
        {
            assertTrue(SettlePatternHandler.getIsRefund(1, Status.ResultStatus.AbandonedQ2, 0));
            assertTrue(SettlePatternHandler.getIsRefund(2, Status.ResultStatus.AbandonedQ2, 0));
            assertTrue(SettlePatternHandler.getIsRefund(3, Status.ResultStatus.AbandonedQ2, 0));
            assertTrue(SettlePatternHandler.getIsRefund(5, Status.ResultStatus.AbandonedQ2, 0));
            assertTrue(SettlePatternHandler.getIsRefund(7, Status.ResultStatus.AbandonedQ2, 0));
            assertTrue(SettlePatternHandler.getIsRefund(8, Status.ResultStatus.AbandonedQ2, 0));
            assertTrue(SettlePatternHandler.getIsRefund(12, Status.ResultStatus.AbandonedQ2, 0));
            assertTrue(SettlePatternHandler.getIsRefund(15, Status.ResultStatus.AbandonedQ2, 0));
            assertTrue(SettlePatternHandler.getIsRefund(20, Status.ResultStatus.AbandonedQ2, 0));
            assertTrue(SettlePatternHandler.getIsRefund(21, Status.ResultStatus.AbandonedQ2, 0));
            assertTrue(!SettlePatternHandler.getIsRefund(609, Status.ResultStatus.AbandonedQ2, 1));
            assertTrue(!SettlePatternHandler.getIsRefund(610, Status.ResultStatus.AbandonedQ2, 1));
            assertTrue(!SettlePatternHandler.getIsRefund(611, Status.ResultStatus.AbandonedQ2, 1));
            assertTrue(!SettlePatternHandler.getIsRefund(612, Status.ResultStatus.AbandonedQ2, 1));
            assertTrue(SettlePatternHandler.getIsRefund(609, Status.ResultStatus.AbandonedQ2, 2));
            assertTrue(SettlePatternHandler.getIsRefund(610, Status.ResultStatus.AbandonedQ2, 2));
            assertTrue(SettlePatternHandler.getIsRefund(611, Status.ResultStatus.AbandonedQ2, 2));
            assertTrue(SettlePatternHandler.getIsRefund(612, Status.ResultStatus.AbandonedQ2, 2));
            assertTrue(SettlePatternHandler.getIsRefund(609, Status.ResultStatus.AbandonedQ2, 3));
            assertTrue(SettlePatternHandler.getIsRefund(610, Status.ResultStatus.AbandonedQ2, 3));
            assertTrue(SettlePatternHandler.getIsRefund(611, Status.ResultStatus.AbandonedQ2, 3));
            assertTrue(SettlePatternHandler.getIsRefund(612, Status.ResultStatus.AbandonedQ2, 3));
            assertTrue(SettlePatternHandler.getIsRefund(609, Status.ResultStatus.AbandonedQ2, 4));
            assertTrue(SettlePatternHandler.getIsRefund(610, Status.ResultStatus.AbandonedQ2, 4));
            assertTrue(SettlePatternHandler.getIsRefund(611, Status.ResultStatus.AbandonedQ2, 4));
            assertTrue(SettlePatternHandler.getIsRefund(612, Status.ResultStatus.AbandonedQ2, 4));
        }
        {
            assertTrue(SettlePatternHandler.getIsRefund(1, Status.ResultStatus.AbandonedQ3, 0));
            assertTrue(SettlePatternHandler.getIsRefund(2, Status.ResultStatus.AbandonedQ3, 0));
            assertTrue(SettlePatternHandler.getIsRefund(3, Status.ResultStatus.AbandonedQ3, 0));
            assertTrue(SettlePatternHandler.getIsRefund(5, Status.ResultStatus.AbandonedQ3, 0));
            assertTrue(!SettlePatternHandler.getIsRefund(7, Status.ResultStatus.AbandonedQ3, 0));
            assertTrue(!SettlePatternHandler.getIsRefund(8, Status.ResultStatus.AbandonedQ3, 0));
            assertTrue(!SettlePatternHandler.getIsRefund(12, Status.ResultStatus.AbandonedQ3, 0));
            assertTrue(!SettlePatternHandler.getIsRefund(15, Status.ResultStatus.AbandonedQ3, 0));
            assertTrue(SettlePatternHandler.getIsRefund(20, Status.ResultStatus.AbandonedQ3, 0));
            assertTrue(!SettlePatternHandler.getIsRefund(21, Status.ResultStatus.AbandonedQ3, 0));
            assertTrue(!SettlePatternHandler.getIsRefund(609, Status.ResultStatus.AbandonedQ3, 1));
            assertTrue(!SettlePatternHandler.getIsRefund(610, Status.ResultStatus.AbandonedQ3, 1));
            assertTrue(!SettlePatternHandler.getIsRefund(611, Status.ResultStatus.AbandonedQ3, 1));
            assertTrue(!SettlePatternHandler.getIsRefund(612, Status.ResultStatus.AbandonedQ3, 1));
            assertTrue(!SettlePatternHandler.getIsRefund(609, Status.ResultStatus.AbandonedQ3, 2));
            assertTrue(!SettlePatternHandler.getIsRefund(610, Status.ResultStatus.AbandonedQ3, 2));
            assertTrue(!SettlePatternHandler.getIsRefund(611, Status.ResultStatus.AbandonedQ3, 2));
            assertTrue(!SettlePatternHandler.getIsRefund(612, Status.ResultStatus.AbandonedQ3, 2));
            assertTrue(SettlePatternHandler.getIsRefund(609, Status.ResultStatus.AbandonedQ3, 3));
            assertTrue(SettlePatternHandler.getIsRefund(610, Status.ResultStatus.AbandonedQ3, 3));
            assertTrue(SettlePatternHandler.getIsRefund(611, Status.ResultStatus.AbandonedQ3, 3));
            assertTrue(SettlePatternHandler.getIsRefund(612, Status.ResultStatus.AbandonedQ3, 3));
            assertTrue(SettlePatternHandler.getIsRefund(609, Status.ResultStatus.AbandonedQ3, 4));
            assertTrue(SettlePatternHandler.getIsRefund(610, Status.ResultStatus.AbandonedQ3, 4));
            assertTrue(SettlePatternHandler.getIsRefund(611, Status.ResultStatus.AbandonedQ3, 4));
            assertTrue(SettlePatternHandler.getIsRefund(612, Status.ResultStatus.AbandonedQ3, 4));
        }
        {
            assertTrue(SettlePatternHandler.getIsRefund(1, Status.ResultStatus.AbandonedQ4, 0));
            assertTrue(SettlePatternHandler.getIsRefund(2, Status.ResultStatus.AbandonedQ4, 0));
            assertTrue(SettlePatternHandler.getIsRefund(3, Status.ResultStatus.AbandonedQ4, 0));
            assertTrue(SettlePatternHandler.getIsRefund(5, Status.ResultStatus.AbandonedQ4, 0));
            assertTrue(!SettlePatternHandler.getIsRefund(7, Status.ResultStatus.AbandonedQ4, 0));
            assertTrue(!SettlePatternHandler.getIsRefund(8, Status.ResultStatus.AbandonedQ4, 0));
            assertTrue(!SettlePatternHandler.getIsRefund(12, Status.ResultStatus.AbandonedQ4, 0));
            assertTrue(!SettlePatternHandler.getIsRefund(15, Status.ResultStatus.AbandonedQ4, 0));
            assertTrue(SettlePatternHandler.getIsRefund(20, Status.ResultStatus.AbandonedQ4, 0));
            assertTrue(!SettlePatternHandler.getIsRefund(21, Status.ResultStatus.AbandonedQ4, 0));
            assertTrue(!SettlePatternHandler.getIsRefund(609, Status.ResultStatus.AbandonedQ4, 1));
            assertTrue(!SettlePatternHandler.getIsRefund(610, Status.ResultStatus.AbandonedQ4, 1));
            assertTrue(!SettlePatternHandler.getIsRefund(611, Status.ResultStatus.AbandonedQ4, 1));
            assertTrue(!SettlePatternHandler.getIsRefund(612, Status.ResultStatus.AbandonedQ4, 1));
            assertTrue(!SettlePatternHandler.getIsRefund(609, Status.ResultStatus.AbandonedQ4, 2));
            assertTrue(!SettlePatternHandler.getIsRefund(610, Status.ResultStatus.AbandonedQ4, 2));
            assertTrue(!SettlePatternHandler.getIsRefund(611, Status.ResultStatus.AbandonedQ4, 2));
            assertTrue(!SettlePatternHandler.getIsRefund(612, Status.ResultStatus.AbandonedQ4, 2));
            assertTrue(!SettlePatternHandler.getIsRefund(609, Status.ResultStatus.AbandonedQ4, 3));
            assertTrue(!SettlePatternHandler.getIsRefund(610, Status.ResultStatus.AbandonedQ4, 3));
            assertTrue(!SettlePatternHandler.getIsRefund(611, Status.ResultStatus.AbandonedQ4, 3));
            assertTrue(!SettlePatternHandler.getIsRefund(612, Status.ResultStatus.AbandonedQ4, 3));
            assertTrue(SettlePatternHandler.getIsRefund(609, Status.ResultStatus.AbandonedQ4, 4));
            assertTrue(SettlePatternHandler.getIsRefund(610, Status.ResultStatus.AbandonedQ4, 4));
            assertTrue(SettlePatternHandler.getIsRefund(611, Status.ResultStatus.AbandonedQ4, 4));
            assertTrue(SettlePatternHandler.getIsRefund(612, Status.ResultStatus.AbandonedQ4, 4));
        }
    }

    function testGetFullTimeBetTypeCategory() public {
        {
            vm.expectRevert("CustomErrors: this bet type is not supported yet");
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                999, 0
            );
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                1, 0
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.FullTime));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                2, 0
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.FullTime));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                3, 0
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.FullTime));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                5, 0
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.FullTime));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                20, 0
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.FullTime));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                413, 0
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.FullTime));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                7, 0
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.HalfTime));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                8, 0
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.HalfTime));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                12, 0
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.HalfTime));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                15, 0
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.HalfTime));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                21, 0
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.HalfTime));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                609, 1
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.Quarter1));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                610, 1
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.Quarter1));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                611, 1
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.Quarter1));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                612, 1
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.Quarter1));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                609, 2
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.Quarter2));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                610, 2
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.Quarter2));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                611, 2
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.Quarter2));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                612, 2
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.Quarter2));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                609, 3
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.Quarter3));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                610, 3
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.Quarter3));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                611, 3
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.Quarter3));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                612, 3
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.Quarter3));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                609, 4
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.Quarter4));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                610, 4
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.Quarter4));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                611, 4
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.Quarter4));
        }
        {
            SettlePatternHandler.BetTypeCategory cat =
                SettlePatternHandler.getBetTypeCategory(
                612, 4
            );
            assertEq(uint8(cat), uint8(SettlePatternHandler.BetTypeCategory.Quarter4));
        }
    }
}
