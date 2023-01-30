// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "test/utils/BaseTest.sol";
import "src/proxy/ERC1967Proxy.sol";
import "src/OutrightBetV1.sol";
import "src/OracleV1.sol";
import "src/engine/outright/OutrightBetEngineV1.sol";

contract BaseOutrightBetV1Test is BaseTest {
    OutrightBetV1 internal outrightBetLogical;
    ERC1967Proxy internal outrightBet;
    OutrightBetEngineV1 internal engine;
    OracleV1 internal oracleLogical;
    ERC1967Proxy internal oracle;

    function setUp() public {
        BaseTest.setupToken();

        vm.startPrank(owner);
        oracleLogical = new OracleV1();
        oracle = new ERC1967Proxy(address(oracleLogical), "");
        OracleV1(address(oracle)).initialize(uploader);
        engine = new OutrightBetEngineV1(100);
        outrightBetLogical = new OutrightBetV1();
        outrightBet = new ERC1967Proxy(address(outrightBetLogical), "");
        OutrightBetV1(address(outrightBet)).initialize(signer, settler, rejecter, address(oracle));
        OutrightBetV1(address(outrightBet)).setTicketEngine(1, address(engine));
        vm.stopPrank();
    }
}
