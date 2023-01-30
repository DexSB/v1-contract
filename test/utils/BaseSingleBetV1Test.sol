// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "test/utils/BaseTest.sol";
import "src/proxy/ERC1967Proxy.sol";
import "src/SingleBetV1.sol";
import "src/OracleV1.sol";
import "src/engine/single/SingleBetEngineV1.sol";

contract BaseSingleBetV1Test is BaseTest {
    SingleBetV1 internal singleBetLogical;
    ERC1967Proxy internal singleBet;
    SingleBetEngineV1 internal engine;
    OracleV1 internal oracleLogical;
    ERC1967Proxy internal oracle;

    function setUp() public {
        BaseTest.setupToken();

        vm.startPrank(owner);
        oracleLogical = new OracleV1();
        oracle = new ERC1967Proxy(address(oracleLogical), "");
        OracleV1(address(oracle)).initialize(uploader);
        engine = new SingleBetEngineV1(100, 100);
        singleBetLogical = new SingleBetV1();
        singleBet = new ERC1967Proxy(address(singleBetLogical), "");
        SingleBetV1(address(singleBet)).initialize(signer, settler, rejecter, address(oracle));
        SingleBetV1(address(singleBet)).setTicketEngine(1, address(engine));
        SingleBetEngineV1(address(engine)).setFreeBetToken(address(freeBetErc20), address(erc20));
        vm.stopPrank();
    }
}
