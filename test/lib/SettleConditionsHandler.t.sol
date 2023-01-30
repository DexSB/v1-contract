// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "test/utils/BaseTest.sol";
import "src/lib/SettleConditionsHandler.sol";

contract ResultHandlerTest is BaseTest {
    function testGetCoditions() public {
        {
            bytes32[] memory conditions = SettleConditionsHandler.getConditions(1, bytes32(""));
            assertEq(conditions[0], keccak256(abi.encode("h")));
            assertEq(conditions[1], keccak256(abi.encode("a")));
        }
        {
            bytes32[] memory conditions = SettleConditionsHandler.getConditions(2, bytes32(""));
            assertEq(conditions[0], keccak256(abi.encode("h")));
            assertEq(conditions[1], keccak256(abi.encode("a")));
        }
        {
            bytes32[] memory conditions = SettleConditionsHandler.getConditions(3, bytes32(""));
            assertEq(conditions[0], keccak256(abi.encode("h")));
            assertEq(conditions[1], keccak256(abi.encode("a")));
        }
        {
            bytes32[] memory conditions = SettleConditionsHandler.getConditions(5, bytes32(""));
            assertEq(conditions[0], keccak256(abi.encode("1")));
            assertEq(conditions[1], keccak256(abi.encode("x")));
            assertEq(conditions[2], keccak256(abi.encode("2")));
        }
        {
            bytes32[] memory conditions = SettleConditionsHandler.getConditions(7, bytes32(""));
            assertEq(conditions[0], keccak256(abi.encode("h")));
            assertEq(conditions[1], keccak256(abi.encode("a")));
        }
        {
            bytes32[] memory conditions = SettleConditionsHandler.getConditions(8, bytes32(""));
            assertEq(conditions[0], keccak256(abi.encode("h")));
            assertEq(conditions[1], keccak256(abi.encode("a")));
        }
        {
            bytes32[] memory conditions = SettleConditionsHandler.getConditions(12, bytes32(""));
            assertEq(conditions[0], keccak256(abi.encode("h")));
            assertEq(conditions[1], keccak256(abi.encode("a")));
        }
        {
            bytes32[] memory conditions = SettleConditionsHandler.getConditions(15, bytes32(""));
            assertEq(conditions[0], keccak256(abi.encode("1")));
            assertEq(conditions[1], keccak256(abi.encode("x")));
            assertEq(conditions[2], keccak256(abi.encode("2")));
        }
        {
            bytes32[] memory conditions = SettleConditionsHandler.getConditions(20, bytes32(""));
            assertEq(conditions[0], keccak256(abi.encode("h")));
            assertEq(conditions[1], keccak256(abi.encode("a")));
        }
        {
            bytes32[] memory conditions = SettleConditionsHandler.getConditions(21, bytes32(""));
            assertEq(conditions[0], keccak256(abi.encode("h")));
            assertEq(conditions[1], keccak256(abi.encode("a")));
        }
        {
            bytes32[] memory conditions = SettleConditionsHandler.getConditions(413, keccak256(abi.encode(abi.encodePacked("1:4"))));
            assertEq(conditions[0], keccak256(abi.encode(abi.encodePacked("1:4"))));
        }
        {
            bytes32[] memory conditions = SettleConditionsHandler.getConditions(609, bytes32(""));
            assertEq(conditions[0], keccak256(abi.encode("h")));
            assertEq(conditions[1], keccak256(abi.encode("a")));
        }
        {
            bytes32[] memory conditions = SettleConditionsHandler.getConditions(610, bytes32(""));
            assertEq(conditions[0], keccak256(abi.encode("o")));
            assertEq(conditions[1], keccak256(abi.encode("u")));
        }
        {
            bytes32[] memory conditions = SettleConditionsHandler.getConditions(611, bytes32(""));
            assertEq(conditions[0], keccak256(abi.encode("o")));
            assertEq(conditions[1], keccak256(abi.encode("e")));
        }
        {
            bytes32[] memory conditions = SettleConditionsHandler.getConditions(612, bytes32(""));
            assertEq(conditions[0], keccak256(abi.encode("h")));
            assertEq(conditions[1], keccak256(abi.encode("a")));
        }
    }
}