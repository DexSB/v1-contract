// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "test/utils/BaseTest.sol";
import "src/lib/SettlementHandler.sol";
import "src/lib/SettleConditionsHandler.sol";

contract SettlementHandlerTest is BaseTest {
    function testFTHandicap() public {
        Status.TicketStatus status;
        {
            status = SettlementHandler.settleSingleBetTicket(
                1,
                keccak256(abi.encode("h")),
                1,
                SettleConditionsHandler.getConditions(
                    1,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                25,
                keccak256(abi.encode("h")),
                1,
                SettleConditionsHandler.getConditions(
                    1,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfWon));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("h")),
                1,
                SettleConditionsHandler.getConditions(
                    1,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Draw));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -25,
                keccak256(abi.encode("h")),
                1,
                SettleConditionsHandler.getConditions(
                    1,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfLost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -75,
                keccak256(abi.encode("h")),
                1,
                SettleConditionsHandler.getConditions(
                    1,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                75,
                keccak256(abi.encode("a")),
                1,
                SettleConditionsHandler.getConditions(
                    1,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                25,
                keccak256(abi.encode("a")),
                1,
                SettleConditionsHandler.getConditions(
                    1,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfLost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("a")),
                1,
                SettleConditionsHandler.getConditions(
                    1,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Draw));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -25,
                keccak256(abi.encode("a")),
                1,
                SettleConditionsHandler.getConditions(
                    1,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfWon));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -75,
                keccak256(abi.encode("a")),
                1,
                SettleConditionsHandler.getConditions(
                    1,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
    }

    function testHTHandicap() public {
        Status.TicketStatus status;
        {
            status = SettlementHandler.settleSingleBetTicket(
                1,
                keccak256(abi.encode("h")),
                7,
                SettleConditionsHandler.getConditions(
                    7,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                25,
                keccak256(abi.encode("h")),
                7,
                SettleConditionsHandler.getConditions(
                    7,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfWon));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("h")),
                7,
                SettleConditionsHandler.getConditions(
                    7,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Draw));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -25,
                keccak256(abi.encode("h")),
                7,
                SettleConditionsHandler.getConditions(
                    7,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfLost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -75,
                keccak256(abi.encode("h")),
                7,
                SettleConditionsHandler.getConditions(
                    7,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                75,
                keccak256(abi.encode("a")),
                7,
                SettleConditionsHandler.getConditions(
                    7,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                25,
                keccak256(abi.encode("a")),
                7,
                SettleConditionsHandler.getConditions(
                    7,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfLost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("a")),
                7,
                SettleConditionsHandler.getConditions(
                    7,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Draw));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -25,
                keccak256(abi.encode("a")),
                7,
                SettleConditionsHandler.getConditions(
                    7,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfWon));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -75,
                keccak256(abi.encode("a")),
                7,
                SettleConditionsHandler.getConditions(
                    7,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
    }

    function testQTHandicap() public {
        Status.TicketStatus status;
        {
            status = SettlementHandler.settleSingleBetTicket(
                1,
                keccak256(abi.encode("h")),
                609,
                SettleConditionsHandler.getConditions(
                    609,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                25,
                keccak256(abi.encode("h")),
                609,
                SettleConditionsHandler.getConditions(
                    609,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfWon));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("h")),
                609,
                SettleConditionsHandler.getConditions(
                    609,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Draw));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -25,
                keccak256(abi.encode("h")),
                609,
                SettleConditionsHandler.getConditions(
                    609,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfLost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -75,
                keccak256(abi.encode("h")),
                609,
                SettleConditionsHandler.getConditions(
                    609,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                75,
                keccak256(abi.encode("a")),
                609,
                SettleConditionsHandler.getConditions(
                    609,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                25,
                keccak256(abi.encode("a")),
                609,
                SettleConditionsHandler.getConditions(
                    609,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfLost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("a")),
                609,
                SettleConditionsHandler.getConditions(
                    609,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Draw));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -25,
                keccak256(abi.encode("a")),
                609,
                SettleConditionsHandler.getConditions(
                    609,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfWon));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -75,
                keccak256(abi.encode("a")),
                609,
                SettleConditionsHandler.getConditions(
                    609,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
    }

    function testFTOddEvent() public {
        Status.TicketStatus status;
        {
            status = SettlementHandler.settleSingleBetTicket(
                100,
                keccak256(abi.encode("h")),
                2,
                SettleConditionsHandler.getConditions(
                    2,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                200,
                keccak256(abi.encode("h")),
                2,
                SettleConditionsHandler.getConditions(
                    2,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                100,
                keccak256(abi.encode("a")),
                2,
                SettleConditionsHandler.getConditions(
                    2,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                200,
                keccak256(abi.encode("a")),
                2,
                SettleConditionsHandler.getConditions(
                    2,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("h")),
                2,
                SettleConditionsHandler.getConditions(
                    2,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("a")),
                2,
                SettleConditionsHandler.getConditions(
                    2,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
    }

    function testHTOddEvent() public {
        Status.TicketStatus status;
        {
            status = SettlementHandler.settleSingleBetTicket(
                100,
                keccak256(abi.encode("h")),
                12,
                SettleConditionsHandler.getConditions(
                    12,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                200,
                keccak256(abi.encode("h")),
                12,
                SettleConditionsHandler.getConditions(
                    12,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                100,
                keccak256(abi.encode("a")),
                12,
                SettleConditionsHandler.getConditions(
                    12,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                200,
                keccak256(abi.encode("a")),
                12,
                SettleConditionsHandler.getConditions(
                    12,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("h")),
                12,
                SettleConditionsHandler.getConditions(
                    12,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("a")),
                12,
                SettleConditionsHandler.getConditions(
                    12,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
    }

    function testQTOddEvent() public {
        Status.TicketStatus status;
        {
            status = SettlementHandler.settleSingleBetTicket(
                100,
                keccak256(abi.encode("o")),
                611,
                SettleConditionsHandler.getConditions(
                    611,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                200,
                keccak256(abi.encode("o")),
                611,
                SettleConditionsHandler.getConditions(
                    611,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                100,
                keccak256(abi.encode("e")),
                611,
                SettleConditionsHandler.getConditions(
                    611,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                200,
                keccak256(abi.encode("e")),
                611,
                SettleConditionsHandler.getConditions(
                    611,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("o")),
                611,
                SettleConditionsHandler.getConditions(
                    611,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("e")),
                611,
                SettleConditionsHandler.getConditions(
                    611,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
    }

    function testFTOverUnder() public {
        Status.TicketStatus status;
        {
            status = SettlementHandler.settleSingleBetTicket(
                75,
                keccak256(abi.encode("h")),
                3,
                SettleConditionsHandler.getConditions(
                    3,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                25,
                keccak256(abi.encode("h")),
                3,
                SettleConditionsHandler.getConditions(
                    3,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfWon));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("h")),
                3,
                SettleConditionsHandler.getConditions(
                    3,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Draw));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -25,
                keccak256(abi.encode("h")),
                3,
                SettleConditionsHandler.getConditions(
                    3,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfLost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -75,
                keccak256(abi.encode("h")),
                3,
                SettleConditionsHandler.getConditions(
                    3,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                75,
                keccak256(abi.encode("a")),
                3,
                SettleConditionsHandler.getConditions(
                    3,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                25,
                keccak256(abi.encode("a")),
                3,
                SettleConditionsHandler.getConditions(
                    3,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfLost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("a")),
                3,
                SettleConditionsHandler.getConditions(
                    3,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Draw));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -25,
                keccak256(abi.encode("a")),
                3,
                SettleConditionsHandler.getConditions(
                    3,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfWon));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -75,
                keccak256(abi.encode("a")),
                3,
                SettleConditionsHandler.getConditions(
                    3,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
    }

    function testHTOverUnder() public {
        Status.TicketStatus status;
        {
            status = SettlementHandler.settleSingleBetTicket(
                75,
                keccak256(abi.encode("h")),
                8,
                SettleConditionsHandler.getConditions(
                    8,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                25,
                keccak256(abi.encode("h")),
                8,
                SettleConditionsHandler.getConditions(
                    8,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfWon));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("h")),
                8,
                SettleConditionsHandler.getConditions(
                    8,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Draw));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -25,
                keccak256(abi.encode("h")),
                8,
                SettleConditionsHandler.getConditions(
                    8,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfLost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -75,
                keccak256(abi.encode("h")),
                8,
                SettleConditionsHandler.getConditions(
                    8,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                75,
                keccak256(abi.encode("a")),
                8,
                SettleConditionsHandler.getConditions(
                    8,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                25,
                keccak256(abi.encode("a")),
                8,
                SettleConditionsHandler.getConditions(
                    8,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfLost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("a")),
                8,
                SettleConditionsHandler.getConditions(
                    8,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Draw));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -25,
                keccak256(abi.encode("a")),
                8,
                SettleConditionsHandler.getConditions(
                    8,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfWon));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -75,
                keccak256(abi.encode("a")),
                8,
                SettleConditionsHandler.getConditions(
                    8,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
    }

    function testQTOverUnder() public {
        Status.TicketStatus status;
        {
            status = SettlementHandler.settleSingleBetTicket(
                75,
                keccak256(abi.encode("o")),
                610,
                SettleConditionsHandler.getConditions(
                    610,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                25,
                keccak256(abi.encode("o")),
                610,
                SettleConditionsHandler.getConditions(
                    610,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfWon));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("o")),
                610,
                SettleConditionsHandler.getConditions(
                    610,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Draw));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -25,
                keccak256(abi.encode("o")),
                610,
                SettleConditionsHandler.getConditions(
                    610,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfLost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -75,
                keccak256(abi.encode("o")),
                610,
                SettleConditionsHandler.getConditions(
                    610,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                75,
                keccak256(abi.encode("u")),
                610,
                SettleConditionsHandler.getConditions(
                    610,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                25,
                keccak256(abi.encode("u")),
                610,
                SettleConditionsHandler.getConditions(
                    610,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfLost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("u")),
                610,
                SettleConditionsHandler.getConditions(
                    610,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Draw));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -25,
                keccak256(abi.encode("u")),
                610,
                SettleConditionsHandler.getConditions(
                    610,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.HalfWon));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -75,
                keccak256(abi.encode("u")),
                610,
                SettleConditionsHandler.getConditions(
                    610,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
    }

    function testFT1x2() public {
        Status.TicketStatus status;
        {
            status = SettlementHandler.settleSingleBetTicket(
                100,
                keccak256(abi.encode("1")),
                5,
                SettleConditionsHandler.getConditions(
                    5,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                100,
                keccak256(abi.encode("x")),
                5,
                SettleConditionsHandler.getConditions(
                    5,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                100,
                keccak256(abi.encode("2")),
                5,
                SettleConditionsHandler.getConditions(
                    5,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("1")),
                5,
                SettleConditionsHandler.getConditions(
                    5,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("x")),
                5,
                SettleConditionsHandler.getConditions(
                    5,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("2")),
                5,
                SettleConditionsHandler.getConditions(
                    5,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -100,
                keccak256(abi.encode("1")),
                5,
                SettleConditionsHandler.getConditions(
                    5,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -100,
                keccak256(abi.encode("x")),
                5,
                SettleConditionsHandler.getConditions(
                    5,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -100,
                keccak256(abi.encode("2")),
                5,
                SettleConditionsHandler.getConditions(
                    5,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
    }

    function testHT1x2() public {
        Status.TicketStatus status;
        {
            status = SettlementHandler.settleSingleBetTicket(
                100,
                keccak256(abi.encode("1")),
                15,
                SettleConditionsHandler.getConditions(
                    15,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                100,
                keccak256(abi.encode("x")),
                15,
                SettleConditionsHandler.getConditions(
                    15,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                100,
                keccak256(abi.encode("2")),
                15,
                SettleConditionsHandler.getConditions(
                    15,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("1")),
                15,
                SettleConditionsHandler.getConditions(
                    15,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("x")),
                15,
                SettleConditionsHandler.getConditions(
                    15,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("2")),
                15,
                SettleConditionsHandler.getConditions(
                    15,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -100,
                keccak256(abi.encode("1")),
                15,
                SettleConditionsHandler.getConditions(
                    15,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -100,
                keccak256(abi.encode("x")),
                15,
                SettleConditionsHandler.getConditions(
                    15,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -100,
                keccak256(abi.encode("2")),
                15,
                SettleConditionsHandler.getConditions(
                    15,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
    }

    function testFTMoneyLine() public {
        Status.TicketStatus status;
        {
            status = SettlementHandler.settleSingleBetTicket(
                100,
                keccak256(abi.encode("h")),
                20,
                SettleConditionsHandler.getConditions(
                    20,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                100,
                keccak256(abi.encode("a")),
                20,
                SettleConditionsHandler.getConditions(
                    20,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("h")),
                20,
                SettleConditionsHandler.getConditions(
                    20,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Draw));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("a")),
                20,
                SettleConditionsHandler.getConditions(
                    20,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Draw));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -100,
                keccak256(abi.encode("h")),
                20,
                SettleConditionsHandler.getConditions(
                    20,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -100,
                keccak256(abi.encode("a")),
                20,
                SettleConditionsHandler.getConditions(
                    20,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
    }

    function testHTMoneyLine() public {
        Status.TicketStatus status;
        {
            status = SettlementHandler.settleSingleBetTicket(
                100,
                keccak256(abi.encode("h")),
                21,
                SettleConditionsHandler.getConditions(
                    21,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                100,
                keccak256(abi.encode("a")),
                21,
                SettleConditionsHandler.getConditions(
                    21,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("h")),
                21,
                SettleConditionsHandler.getConditions(
                    21,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Draw));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("a")),
                21,
                SettleConditionsHandler.getConditions(
                    21,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Draw));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -100,
                keccak256(abi.encode("h")),
                21,
                SettleConditionsHandler.getConditions(
                    21,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -100,
                keccak256(abi.encode("a")),
                21,
                SettleConditionsHandler.getConditions(
                    21,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
    }

    function testQTMoneyLine() public {
        Status.TicketStatus status;
        {
            status = SettlementHandler.settleSingleBetTicket(
                100,
                keccak256(abi.encode("h")),
                612,
                SettleConditionsHandler.getConditions(
                    612,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                100,
                keccak256(abi.encode("a")),
                612,
                SettleConditionsHandler.getConditions(
                    612,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("h")),
                612,
                SettleConditionsHandler.getConditions(
                    612,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Draw));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                0,
                keccak256(abi.encode("a")),
                612,
                SettleConditionsHandler.getConditions(
                    612,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Draw));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -100,
                keccak256(abi.encode("h")),
                612,
                SettleConditionsHandler.getConditions(
                    612,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -100,
                keccak256(abi.encode("a")),
                612,
                SettleConditionsHandler.getConditions(
                    612,
                    keccak256(abi.encode(""))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
    }

    function testCorrectScore() public {
        Status.TicketStatus status;
        {
            status = SettlementHandler.settleSingleBetTicket(
                -100,
                keccak256(abi.encode("1:1")),
                413,
                SettleConditionsHandler.getConditions(
                    413,
                    keccak256(abi.encode("1:1"))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Won));
        }
        {
            status = SettlementHandler.settleSingleBetTicket(
                -100,
                keccak256(abi.encode("1:2")),
                413,
                SettleConditionsHandler.getConditions(
                    413,
                    keccak256(abi.encode("1:1"))
                ),
                3 * 1000000,
                1 * 1000000,
                100
            );

            assertEq(uint8(status), uint8(Status.TicketStatus.Lost));
        }
    }
}
