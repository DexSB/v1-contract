// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "test/utils/BaseTest.sol";
import "src/Faucet.sol";

contract FaucetTest is BaseTest {
    Faucet internal faucet;

    function setUp() public {
        BaseTest.setupToken();

        vm.startPrank(owner);
        faucet = new Faucet();

        TestNextfortuneToken(erc20).mintTo(address(faucet), 10000 * 1000000);
        deal(address(faucet), 10000 * 1e18);
        vm.stopPrank();
    }

    function testFaucet() public {
        assertEq(IERC20(erc20).balanceOf(address(faucet)), 10000 * 1000000);
        assertEq(address(faucet).balance, 10000 * 1e18);

        address alice = makeAddr("alice");
        vm.prank(owner);
        faucet.sendTokens(alice, address(erc20), 100, 2);

        assertEq(IERC20(erc20).balanceOf(address(alice)), 100 * 1000000);
        assertEq(address(alice).balance, 2 * 1e18);

        vm.prank(owner);
        vm.expectRevert("CustomErrors: customer exists");
        faucet.sendTokens(alice, address(erc20), 100, 2);
    }

    function testDepositNativeTokenToContract() public {
        address alice = makeAddr("alice");
        deal(alice, 1000 * 1e18);

        vm.prank(alice);
        faucet.deposit{value: 10*1e18}();

        assertEq(address(faucet).balance, 10010 * 1e18);
    }
}