// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "test/utils/BaseTest.sol";
import "src/proxy/ERC1967Proxy.sol";
import "src/OracleV1.sol";

contract BaseOracleV1Test is BaseTest {
    OracleV1 internal logical;
    ERC1967Proxy internal oracle;

    function setUp() public {
        vm.startPrank(owner);
        logical = new OracleV1();
        oracle = new ERC1967Proxy(address(logical), "");
        OracleV1(address(oracle)).initialize(uploader);
        vm.stopPrank();
    }
}
