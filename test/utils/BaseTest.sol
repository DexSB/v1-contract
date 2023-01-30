// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "test/lib/TestNextfortuneToken.sol";
import "test/lib/TestFreeBetToken.sol";

contract BaseTest is Test {
    TestNextfortuneToken internal erc20;
    TestFreeBetToken internal freeBetErc20;

    address internal owner = 0x8CFd89687B7540e8c6c33B25aF5be6539ff33a44;
    uint256 internal ownerKey =
        0xa7f52c0962997a32a4e4ab1417462029c13463983dbabff50b883ebca5d7152e;
    
    address internal customer = 0xf0b948bE4d87Db6F48c027BdF07D21359462d27c;
    uint256 internal customerKey =
        0x90f0db71f11b45aa752799cbae952519eb0b603804db2c1677761a4594fb181b;

    address internal licensee = 0x67B7Dc52B1E638242Fe81cb0770c7B5B0A3354D7;
    uint256 internal licenseeKey =
        0xf7458cd3d6c01f328bcd772222e8d7eedc1b2dcc10dd0b536abcb6cfe0f7d8a3;

    address internal signer = 0x2d901E0efb6bF67718B6D65D33bCDbAE5005e7d9;
    uint256 internal signerKey =
        0x1d0118346a60e95e61a1e8ffb12a64f7c8bb57f71a9ea3185ef878b649f27439;

    address internal settler = 0x9CC512dBc79D2E53f3F271B8249f98e0Fa0EdF26;
    uint256 internal settlerKey =
        0xc07ee0839bc777ac33b722917304a3c577bf4c10a32840b5e69728a41415fbf8;
    
    address internal rejecter = 0xf55185877D6a5b4D042E83B3Acc06950Ba31C713;
    uint256 internal rejecterKey =
        0x9d1d47c3d0228f4ad58ae1f19a2cd18d51c1a88f668de4e6aa03ddb516872018;
    
    address internal uploader = 0x6501758000Ac1b9e195828696C0838bed8c513fa;
    uint256 internal uploaderKey =
        0xa4d9db0ea4087a1f2c9578acc320c1ca75424bf0e5bbbb448d43c892677a02f6;

    function setupToken() public {
        erc20 = new TestNextfortuneToken(0);
        freeBetErc20 = new TestFreeBetToken(0);

        vm.startPrank(customer);
        TestNextfortuneToken(erc20).mint(10000 * 1000000);
        TestFreeBetToken(freeBetErc20).mint(10000 * 1000000);
        vm.stopPrank();

        vm.startPrank(licensee);
        TestNextfortuneToken(erc20).mint(10000 * 1000000);
        TestFreeBetToken(freeBetErc20).mint(10000 * 1000000);
        vm.stopPrank();
    }
}
