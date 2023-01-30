// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "test/utils/BaseTest.sol";
import "src/lib/ResultHandler.sol";
import "src/lib/BetType.sol";

contract ResultHandlerTest is BaseTest {
    function testSoccerFTHandicap() public {
        int256 result;
        {
            result = ResultHandler.getTicketResult(
                1,
                0,
                1,
                1,
                0,
                0,
                25,
                0,
                100
            );
            assertEq(result, 75);
        }
        {
            result = ResultHandler.getTicketResult(
                4,
                2,
                1,
                1,
                1,
                1,
                25,
                0,
                100
            );
            assertEq(result, 175);
        }
        {
            result = ResultHandler.getTicketResult(
                4,
                1,
                1,
                1,
                3,
                1,
                0,
                25,
                100
            );
            assertEq(result, 125);
        }
        {
            result = ResultHandler.getTicketResult(
                3,
                1,
                1,
                1,
                3,
                1,
                0,
                25,
                100
            );
            assertEq(result, 25);
        }
        {
            result = ResultHandler.getTicketResult(3, 1, 1, 1, 3, 1, 0, 0, 100);
            assertEq(result, 0);
        }
        {
            result = ResultHandler.getTicketResult(
                2,
                1,
                1,
                1,
                2,
                1,
                25,
                0,
                100
            );
            assertEq(result, -25);
        }
        {
            result = ResultHandler.getTicketResult(
                2,
                3,
                1,
                1,
                2,
                1,
                25,
                0,
                100
            );
            assertEq(result, -225);
        }
    }

    function testSoccerHTHandicap() public {
        int256 result;
        {
            result = ResultHandler.getTicketResult(
                1,
                0,
                1,
                7,
                0,
                0,
                25,
                0,
                100
            );
            assertEq(result, 75);
        }
        {
            result = ResultHandler.getTicketResult(
                4,
                2,
                1,
                7,
                1,
                1,
                25,
                0,
                100
            );
            assertEq(result, 175);
        }
        {
            result = ResultHandler.getTicketResult(
                4,
                1,
                1,
                7,
                3,
                1,
                0,
                25,
                100
            );
            assertEq(result, 125);
        }
        {
            result = ResultHandler.getTicketResult(
                3,
                1,
                1,
                7,
                3,
                1,
                0,
                25,
                100
            );
            assertEq(result, 25);
        }
        {
            result = ResultHandler.getTicketResult(3, 1, 1, 7, 3, 1, 0, 0, 100);
            assertEq(result, 0);
        }
        {
            result = ResultHandler.getTicketResult(
                2,
                1,
                1,
                7,
                2,
                1,
                25,
                0,
                100
            );
            assertEq(result, -25);
        }
        {
            result = ResultHandler.getTicketResult(
                2,
                3,
                1,
                7,
                2,
                1,
                25,
                0,
                100
            );
            assertEq(result, -225);
        }
    }

    function testBasketballFTHandicap() public {
        int256 result;
        {
            result = ResultHandler.getTicketResult(
                55,
                45,
                2,
                1,
                0,
                0,
                150,
                0,
                100
            );
            assertEq(result, 850);
        }
        {
            result = ResultHandler.getTicketResult(
                55,
                45,
                2,
                1,
                100,
                100,
                0,
                150,
                100
            );
            assertEq(result, 1150);
        }
        {
            result = ResultHandler.getTicketResult(
                55,
                55,
                2,
                1,
                3,
                1,
                0,
                0,
                100
            );
            assertEq(result, 0);
        }
        {
            result = ResultHandler.getTicketResult(
                45,
                55,
                2,
                1,
                2,
                1,
                150,
                0,
                100
            );
            assertEq(result, -1150);
        }
        {
            result = ResultHandler.getTicketResult(
                45,
                55,
                2,
                1,
                2,
                1,
                0,
                150,
                100
            );
            assertEq(result, -850);
        }
    }

    function testBasketballHTHandicap() public {
        int256 result;
        {
            result = ResultHandler.getTicketResult(
                55,
                45,
                2,
                7,
                0,
                0,
                150,
                0,
                100
            );
            assertEq(result, 850);
        }
        {
            result = ResultHandler.getTicketResult(
                55,
                45,
                2,
                7,
                100,
                100,
                0,
                150,
                100
            );
            assertEq(result, 1150);
        }
        {
            result = ResultHandler.getTicketResult(
                55,
                55,
                2,
                7,
                3,
                1,
                0,
                0,
                100
            );
            assertEq(result, 0);
        }
        {
            result = ResultHandler.getTicketResult(
                45,
                55,
                2,
                7,
                2,
                1,
                150,
                0,
                100
            );
            assertEq(result, -1150);
        }
        {
            result = ResultHandler.getTicketResult(
                45,
                55,
                2,
                7,
                2,
                1,
                0,
                150,
                100
            );
            assertEq(result, -850);
        }
    }

    function testBasketballQTHandicap() public {
        int256 result;
        {
            result = ResultHandler.getTicketResult(
                55,
                45,
                2,
                609,
                0,
                0,
                150,
                0,
                100
            );
            assertEq(result, 850);
        }
        {
            result = ResultHandler.getTicketResult(
                55,
                45,
                2,
                609,
                100,
                100,
                0,
                150,
                100
            );
            assertEq(result, 1150);
        }
        {
            result = ResultHandler.getTicketResult(
                55,
                55,
                2,
                609,
                3,
                1,
                0,
                0,
                100
            );
            assertEq(result, 0);
        }
        {
            result = ResultHandler.getTicketResult(
                45,
                55,
                2,
                609,
                2,
                1,
                150,
                0,
                100
            );
            assertEq(result, -1150);
        }
        {
            result = ResultHandler.getTicketResult(
                45,
                55,
                2,
                609,
                2,
                1,
                0,
                150,
                100
            );
            assertEq(result, -850);
        }
    }

    function testFTOddEven() public {
        int256 result;
        {
            result = ResultHandler.getTicketResult(
                55,
                45,
                1,
                2,
                0,
                0,
                150,
                0,
                100
            );
            assertEq(result, 10000);
        }
        {
            result = ResultHandler.getTicketResult(
                55,
                45,
                2,
                2,
                100,
                100,
                0,
                150,
                100
            );
            assertEq(result, 10000);
        }
        {
            result = ResultHandler.getTicketResult(
                55,
                55,
                1,
                2,
                3,
                1,
                0,
                0,
                100
            );
            assertEq(result, 11000);
        }
        {
            result = ResultHandler.getTicketResult(
                55,
                55,
                2,
                2,
                3,
                1,
                0,
                0,
                100
            );
            assertEq(result, 11000);
        }
        {
            result = ResultHandler.getTicketResult(
                45,
                55,
                1,
                2,
                2,
                1,
                150,
                0,
                100
            );
            assertEq(result, 10000);
        }
        {
            result = ResultHandler.getTicketResult(
                45,
                55,
                2,
                2,
                2,
                1,
                0,
                150,
                100
            );
            assertEq(result, 10000);
        }
    }

    function testHTOddEven() public {
        int256 result;
        {
            result = ResultHandler.getTicketResult(
                55,
                45,
                1,
                12,
                0,
                0,
                150,
                0,
                100
            );
            assertEq(result, 10000);
        }
        {
            result = ResultHandler.getTicketResult(
                55,
                45,
                2,
                12,
                100,
                100,
                0,
                150,
                100
            );
            assertEq(result, 10000);
        }
        {
            result = ResultHandler.getTicketResult(
                55,
                55,
                1,
                12,
                3,
                1,
                0,
                0,
                100
            );
            assertEq(result, 11000);
        }
        {
            result = ResultHandler.getTicketResult(
                55,
                55,
                2,
                12,
                3,
                1,
                0,
                0,
                100
            );
            assertEq(result, 11000);
        }
        {
            result = ResultHandler.getTicketResult(
                45,
                55,
                1,
                12,
                2,
                1,
                150,
                0,
                100
            );
            assertEq(result, 10000);
        }
        {
            result = ResultHandler.getTicketResult(
                45,
                55,
                2,
                12,
                2,
                1,
                0,
                150,
                100
            );
            assertEq(result, 10000);
        }
    }

    function testQTOddEven() public {
        int256 result;
        {
            result = ResultHandler.getTicketResult(
                55,
                45,
                1,
                611,
                0,
                0,
                150,
                0,
                100
            );
            assertEq(result, 10000);
        }
        {
            result = ResultHandler.getTicketResult(
                55,
                45,
                2,
                611,
                100,
                100,
                0,
                150,
                100
            );
            assertEq(result, 10000);
        }
        {
            result = ResultHandler.getTicketResult(
                55,
                55,
                1,
                611,
                3,
                1,
                0,
                0,
                100
            );
            assertEq(result, 11000);
        }
        {
            result = ResultHandler.getTicketResult(
                55,
                55,
                2,
                611,
                3,
                1,
                0,
                0,
                100
            );
            assertEq(result, 11000);
        }
        {
            result = ResultHandler.getTicketResult(
                45,
                55,
                1,
                611,
                2,
                1,
                150,
                0,
                100
            );
            assertEq(result, 10000);
        }
        {
            result = ResultHandler.getTicketResult(
                45,
                55,
                2,
                611,
                2,
                1,
                0,
                150,
                100
            );
            assertEq(result, 10000);
        }
    }

    function testFTOverUnder() public {
        int256 result;
        {
            result = ResultHandler.getTicketResult(
                3,
                1,
                1,
                3,
                0,
                0,
                25,
                0,
                100
            );
            assertEq(result, 375);
        }
        {
            result = ResultHandler.getTicketResult(
                3,
                3,
                1,
                3,
                100,
                100,
                0,
                25,
                100
            );
            assertEq(result, 600);
        }
        {
            result = ResultHandler.getTicketResult(2, 2, 1, 3, 3, 1, 0, 0, 100);
            assertEq(result, 400);
        }
        {
            result = ResultHandler.getTicketResult(
                32,
                33,
                2,
                3,
                2,
                1,
                0,
                25,
                100
            );
            assertEq(result, 6500);
        }
    }

    function testHTOverUnder() public {
        int256 result;
        {
            result = ResultHandler.getTicketResult(
                3,
                1,
                1,
                8,
                0,
                0,
                25,
                0,
                100
            );
            assertEq(result, 375);
        }
        {
            result = ResultHandler.getTicketResult(
                3,
                3,
                1,
                8,
                100,
                100,
                0,
                25,
                100
            );
            assertEq(result, 600);
        }
        {
            result = ResultHandler.getTicketResult(2, 2, 1, 8, 3, 1, 0, 0, 100);
            assertEq(result, 400);
        }
        {
            result = ResultHandler.getTicketResult(
                32,
                33,
                2,
                8,
                2,
                1,
                0,
                25,
                100
            );
            assertEq(result, 6500);
        }
    }

    function testQTOverUnder() public {
        int256 result;
        {
            result = ResultHandler.getTicketResult(
                3,
                1,
                1,
                610,
                0,
                0,
                25,
                0,
                100
            );
            assertEq(result, 375);
        }
        {
            result = ResultHandler.getTicketResult(
                3,
                3,
                1,
                610,
                100,
                100,
                0,
                25,
                100
            );
            assertEq(result, 600);
        }
        {
            result = ResultHandler.getTicketResult(
                2,
                2,
                1,
                610,
                3,
                1,
                0,
                0,
                100
            );
            assertEq(result, 400);
        }
        {
            result = ResultHandler.getTicketResult(
                32,
                33,
                2,
                610,
                2,
                1,
                0,
                25,
                100
            );
            assertEq(result, 6500);
        }
    }

    function testFT1x2() public {
        int256 result;
        {
            result = ResultHandler.getTicketResult(
                3,
                1,
                1,
                5,
                0,
                0,
                25,
                0,
                100
            );
            assertEq(result, 200);
        }
        {
            result = ResultHandler.getTicketResult(
                3,
                3,
                1,
                5,
                100,
                100,
                0,
                25,
                100
            );
            assertEq(result, 0);
        }
        {
            result = ResultHandler.getTicketResult(2, 3, 1, 5, 3, 1, 0, 0, 100);
            assertEq(result, -100);
        }
    }

    function testHT1x2() public {
        int256 result;
        {
            result = ResultHandler.getTicketResult(
                3,
                1,
                1,
                15,
                0,
                0,
                25,
                0,
                100
            );
            assertEq(result, 200);
        }
        {
            result = ResultHandler.getTicketResult(
                3,
                3,
                1,
                15,
                100,
                100,
                0,
                25,
                100
            );
            assertEq(result, 0);
        }
        {
            result = ResultHandler.getTicketResult(
                2,
                3,
                1,
                15,
                3,
                1,
                0,
                0,
                100
            );
            assertEq(result, -100);
        }
    }

    function testFTMoneyLine() public {
        int256 result;
        {
            result = ResultHandler.getTicketResult(
                33,
                22,
                2,
                20,
                0,
                0,
                25,
                0,
                100
            );
            assertEq(result, 1100);
        }
        {
            result = ResultHandler.getTicketResult(
                33,
                33,
                2,
                20,
                100,
                100,
                0,
                25,
                100
            );
            assertEq(result, 0);
        }
        {
            result = ResultHandler.getTicketResult(
                25,
                38,
                2,
                20,
                3,
                1,
                0,
                0,
                100
            );
            assertEq(result, -1300);
        }
    }

    function testHTMoneyLine() public {
        int256 result;
        {
            result = ResultHandler.getTicketResult(
                33,
                22,
                2,
                21,
                0,
                0,
                25,
                0,
                100
            );
            assertEq(result, 1100);
        }
        {
            result = ResultHandler.getTicketResult(
                33,
                33,
                2,
                21,
                100,
                100,
                0,
                25,
                100
            );
            assertEq(result, 0);
        }
        {
            result = ResultHandler.getTicketResult(
                25,
                38,
                2,
                21,
                3,
                1,
                0,
                0,
                100
            );
            assertEq(result, -1300);
        }
    }

    function testQTMoneyLine() public {
        int256 result;
        {
            result = ResultHandler.getTicketResult(
                33,
                22,
                2,
                612,
                0,
                0,
                25,
                0,
                100
            );
            assertEq(result, 1100);
        }
        {
            result = ResultHandler.getTicketResult(
                33,
                33,
                2,
                612,
                100,
                100,
                0,
                25,
                100
            );
            assertEq(result, 0);
        }
        {
            result = ResultHandler.getTicketResult(
                25,
                38,
                2,
                612,
                3,
                1,
                0,
                0,
                100
            );
            assertEq(result, -1300);
        }
    }

    function testTennisFTGameHandicap() public {
        int256 result;
        {
            result = ResultHandler.getTicketResult(
                17,
                8,
                5,
                BetType.FTGameHandicap,
                0,
                0,
                0,
                0,
                100
            );
            assertEq(result, 900);
        }
    }
}
