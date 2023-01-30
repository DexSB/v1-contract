// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "test/utils/BaseOutrightBetV1Test.sol";
import "test/utils/OutrightBetTicketFactoryV1.sol";
import "test/utils/OutrightResultFactoryV1.sol";

contract OutrightBetV1Test is BaseOutrightBetV1Test {
    function testSettleBet() public {
        uint256 customerBalance = IERC20(address(erc20)).balanceOf(customer);
        uint256 licenseeBalance = IERC20(address(erc20)).balanceOf(licensee);

        OutrightBetTicketV1.SourceOutrightBet memory source =
            OutrightBetTicketFactoryV1.createDefaultTicket(customer, licensee, address(erc20));

        vm.prank(licensee);
        IERC20(address(erc20)).approve(address(outrightBet), 1000000 * 1000000);

        vm.startPrank(customer);
        IERC20(address(erc20)).approve(address(outrightBet), 1000000 * 1000000);
        uint256 nonce = OutrightBetV1(address(outrightBet)).getNonce(customer);
        bytes32 ticketHash = OutrightBetTicketFactoryV1.createTicketHash(customer, nonce, source);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerKey, ticketHash);
        OutrightBetV1(address(outrightBet)).placeOutrightBet(
            1,
            abi.encode(
                source,
                Signature.Vrs(v, r, s)
            )
        );
        vm.stopPrank();

        assertEq(IERC20(address(erc20)).balanceOf(customer), customerBalance - 1000000);
        assertEq(IERC20(address(erc20)).balanceOf(licensee), licenseeBalance - 2000000);

        OutrightResultV1.OutrightEvent memory bytesResult =
            OutrightResultFactoryV1.createDefaultBytesResult();
        vm.prank(uploader);
        IOracleV1(address(oracle)).uploadOutrightResult(1, abi.encode(bytesResult));
        (Status.OutrightTeamStatus status, uint256 deadHeat) = IOracleV1(address(oracle)).getOutrightResult(1, 1);
        assertEq(uint8(status), uint8(Status.OutrightTeamStatus.Won));
        assertEq(deadHeat, 2);

        uint256[] memory transIds = new uint256[](1);
        transIds[0] = 1;
        vm.expectRevert("CustomErrors: caller is not the settler");
        OutrightBetV1(address(outrightBet)).settleBet(1, transIds);
        vm.prank(settler);
        OutrightBetV1(address(outrightBet)).settleBet(1, transIds);
        assertEq(IERC20(address(erc20)).balanceOf(customer), customerBalance + 1000000);
        assertEq(IERC20(address(erc20)).balanceOf(licensee), licenseeBalance - 1000000);
    }

    function testSettleNoResultBet() public {
        uint256 customerBalance = IERC20(address(erc20)).balanceOf(customer);
        uint256 licenseeBalance = IERC20(address(erc20)).balanceOf(licensee);

        OutrightBetTicketV1.SourceOutrightBet memory source =
            OutrightBetTicketFactoryV1.createDefaultTicket(customer, licensee, address(erc20));

        vm.prank(licensee);
        IERC20(address(erc20)).approve(address(outrightBet), 1000000 * 1000000);

        vm.startPrank(customer);
        IERC20(address(erc20)).approve(address(outrightBet), 1000000 * 1000000);
        uint256 nonce = OutrightBetV1(address(outrightBet)).getNonce(customer);
        bytes32 ticketHash = OutrightBetTicketFactoryV1.createTicketHash(customer, nonce, source);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerKey, ticketHash);
        OutrightBetV1(address(outrightBet)).placeOutrightBet(
            1,
            abi.encode(
                source,
                Signature.Vrs(v, r, s)
            )
        );
        vm.stopPrank();

        assertEq(IERC20(address(erc20)).balanceOf(customer), customerBalance - 1000000);
        assertEq(IERC20(address(erc20)).balanceOf(licensee), licenseeBalance - 2000000);

        uint256[] memory transIds = new uint256[](1);
        transIds[0] = 1;
        vm.expectRevert("CustomErrors: caller is not the settler");
        OutrightBetV1(address(outrightBet)).settleBet(1, transIds);
        vm.prank(settler);
        vm.expectRevert("CustomErrors: result is not uploaded");
        OutrightBetV1(address(outrightBet)).settleBet(1, transIds);
        assertEq(IERC20(address(erc20)).balanceOf(customer), customerBalance - 1000000);
        assertEq(IERC20(address(erc20)).balanceOf(licensee), licenseeBalance - 2000000);
    }

    function testPlaceOutrightBet() public {
        uint256 customerBalance = IERC20(address(erc20)).balanceOf(customer);
        uint256 licenseeBalance = IERC20(address(erc20)).balanceOf(licensee);

        OutrightBetTicketV1.SourceOutrightBet memory source =
            OutrightBetTicketFactoryV1.createDefaultTicket(customer, licensee, address(erc20));

        vm.prank(licensee);
        IERC20(address(erc20)).approve(address(outrightBet), 1000000 * 1000000);

        vm.startPrank(customer);
        IERC20(address(erc20)).approve(address(outrightBet), 1000000 * 1000000);
        uint256 nonce = OutrightBetV1(address(outrightBet)).getNonce(customer);
        bytes32 ticketHash = OutrightBetTicketFactoryV1.createTicketHash(customer, nonce, source);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerKey, ticketHash);
        OutrightBetV1(address(outrightBet)).placeOutrightBet(
            1,
            abi.encode(
                source,
                Signature.Vrs(v, r, s)
            )
        );
        vm.stopPrank();

        assertEq(IERC20(address(erc20)).balanceOf(customer), customerBalance - 1000000);
        assertEq(IERC20(address(erc20)).balanceOf(licensee), licenseeBalance - 2000000);
    }

    function testRejectBet() public {
        uint256 customerBalance = IERC20(address(erc20)).balanceOf(customer);
        uint256 licenseeBalance = IERC20(address(erc20)).balanceOf(licensee);

        OutrightBetTicketV1.SourceOutrightBet memory source =
            OutrightBetTicketFactoryV1.createDefaultTicket(customer, licensee, address(erc20));

        vm.prank(licensee);
        IERC20(address(erc20)).approve(address(outrightBet), 1000000 * 1000000);

        vm.startPrank(customer);
        IERC20(address(erc20)).approve(address(outrightBet), 1000000 * 1000000);
        uint256 nonce = OutrightBetV1(address(outrightBet)).getNonce(customer);
        bytes32 ticketHash = OutrightBetTicketFactoryV1.createTicketHash(customer, nonce, source);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerKey, ticketHash);
        OutrightBetV1(address(outrightBet)).placeOutrightBet(
            1,
            abi.encode(
                source,
                Signature.Vrs(v, r, s)
            )
        );
        vm.stopPrank();

        assertEq(IERC20(address(erc20)).balanceOf(customer), customerBalance - 1000000);
        assertEq(IERC20(address(erc20)).balanceOf(licensee), licenseeBalance - 2000000);

        uint256[] memory transIds = new uint256[](1);
        transIds[0] = 1;
        vm.expectRevert("CustomErrors: caller is not the rejecter");
        OutrightBetV1(address(outrightBet)).rejectBet(transIds);
        vm.prank(rejecter);
        OutrightBetV1(address(outrightBet)).rejectBet(transIds);
        assertEq(IERC20(address(erc20)).balanceOf(customer), customerBalance);
        assertEq(IERC20(address(erc20)).balanceOf(licensee), licenseeBalance);
    }

    function testPause() public {
        vm.prank(owner);
        OutrightBetV1(address(outrightBet)).pause();
    }

    function testUnpause() public {
        vm.expectRevert("Ownable: caller is not the owner");
        OutrightBetV1(address(outrightBet)).unpause();
        vm.expectRevert("Pausable: not paused");
        vm.startPrank(owner);
        OutrightBetV1(address(outrightBet)).unpause();
        OutrightBetV1(address(outrightBet)).pause();
        OutrightBetV1(address(outrightBet)).unpause();
        vm.stopPrank();
    }

    function testGetBet() public {
        uint256 customerBalance = IERC20(address(erc20)).balanceOf(customer);
        uint256 licenseeBalance = IERC20(address(erc20)).balanceOf(licensee);

        BytesTicket.OutrightBetTicketV1 memory ticket =
            OutrightBetV1(address(outrightBet)).getBet(1);
        assertEq(ticket.version, 0);
        

        OutrightBetTicketV1.SourceOutrightBet memory source =
            OutrightBetTicketFactoryV1.createDefaultTicket(customer, licensee, address(erc20));

        vm.prank(licensee);
        IERC20(address(erc20)).approve(address(outrightBet), 1000000 * 1000000);

        vm.startPrank(customer);
        IERC20(address(erc20)).approve(address(outrightBet), 1000000 * 1000000);
        uint256 nonce = OutrightBetV1(address(outrightBet)).getNonce(customer);
        bytes32 ticketHash = OutrightBetTicketFactoryV1.createTicketHash(customer, nonce, source);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerKey, ticketHash);
        OutrightBetV1(address(outrightBet)).placeOutrightBet(
            1,
            abi.encode(
                source,
                Signature.Vrs(v, r, s)
            )
        );
        vm.stopPrank();

        assertEq(IERC20(address(erc20)).balanceOf(customer), customerBalance - 1000000);
        assertEq(IERC20(address(erc20)).balanceOf(licensee), licenseeBalance - 2000000);

        ticket = OutrightBetV1(address(outrightBet)).getBet(1);
        
        assertEq(ticket.version, 1);
    }

    function testSetRejecter() public {
        vm.expectRevert("Ownable: caller is not the owner");
        OutrightBetV1(address(outrightBet)).setRejecter(address(rejecter));
        vm.prank(owner);
        OutrightBetV1(address(outrightBet)).setRejecter(address(rejecter));
    }

    function testSetTicketEngine() public {
        vm.expectRevert("Ownable: caller is not the owner");
        OutrightBetV1(address(outrightBet)).setTicketEngine(2, address(0));
        vm.prank(owner);
        OutrightBetV1(address(outrightBet)).setTicketEngine(2, address(0));
    }

    function testSetSigner() public {
        vm.expectRevert("Ownable: caller is not the owner");
        OutrightBetV1(address(outrightBet)).setSigner(address(signer));
        vm.prank(owner);
        OutrightBetV1(address(outrightBet)).setSigner(address(signer));
    }

    function testSetSettler() public {
        vm.expectRevert("Ownable: caller is not the owner");
        OutrightBetV1(address(outrightBet)).setSettler(address(settler));
        vm.prank(owner);
        OutrightBetV1(address(outrightBet)).setSettler(address(settler));
    }

    function testSetOracle() public {
        vm.expectRevert("Ownable: caller is not the owner");
        OutrightBetV1(address(outrightBet)).setOracle(address(oracle));
        vm.prank(owner);
        OutrightBetV1(address(outrightBet)).setOracle(address(oracle));
    }

    function testGetNonce() public {
        uint256 customerBalance = IERC20(address(erc20)).balanceOf(customer);
        uint256 licenseeBalance = IERC20(address(erc20)).balanceOf(licensee);

        BytesTicket.OutrightBetTicketV1 memory ticket =
            OutrightBetV1(address(outrightBet)).getBet(1);
        assertEq(ticket.version, 0);
        

        OutrightBetTicketV1.SourceOutrightBet memory source =
            OutrightBetTicketFactoryV1.createDefaultTicket(customer, licensee, address(erc20));

        vm.prank(licensee);
        IERC20(address(erc20)).approve(address(outrightBet), 1000000 * 1000000);

        vm.startPrank(customer);
        IERC20(address(erc20)).approve(address(outrightBet), 1000000 * 1000000);
        uint256 nonce = OutrightBetV1(address(outrightBet)).getNonce(customer);
        assertEq(nonce, 0);
        bytes32 ticketHash = OutrightBetTicketFactoryV1.createTicketHash(customer, nonce, source);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerKey, ticketHash);
        OutrightBetV1(address(outrightBet)).placeOutrightBet(
            1,
            abi.encode(
                source,
                Signature.Vrs(v, r, s)
            )
        );
        vm.stopPrank();

        assertEq(IERC20(address(erc20)).balanceOf(customer), customerBalance - 1000000);
        assertEq(IERC20(address(erc20)).balanceOf(licensee), licenseeBalance - 2000000);

        nonce = OutrightBetV1(address(outrightBet)).getNonce(customer);
        assertEq(nonce, 1);
    }

    function testGetTicketEngine() public {
        address response = OutrightBetV1(address(outrightBet)).getTicketEngine(1);
        assertEq(response, address(engine));
    }
    
    function testGetRejecter() public {
        address response = OutrightBetV1(address(outrightBet)).getRejecter();
        assertEq(response, rejecter);
    }

    function testGetSigner() public {
        address response = OutrightBetV1(address(outrightBet)).getSigner();
        assertEq(response, signer);
    }

    function testGetSettler() public {
        address response = OutrightBetV1(address(outrightBet)).getSettler();
        assertEq(response, settler);
    }

    function testGetOracle() public {
        address response = OutrightBetV1(address(outrightBet)).getOracle();
        assertEq(response, address(oracle));
    }

    function testGetTicketCount() public {
        uint256 customerBalance = IERC20(address(erc20)).balanceOf(customer);
        uint256 licenseeBalance = IERC20(address(erc20)).balanceOf(licensee);

        OutrightBetTicketV1.SourceOutrightBet memory source =
            OutrightBetTicketFactoryV1.createDefaultTicket(customer, licensee, address(erc20));

        vm.prank(licensee);
        IERC20(address(erc20)).approve(address(outrightBet), 1000000 * 1000000);

        vm.startPrank(customer);
        IERC20(address(erc20)).approve(address(outrightBet), 1000000 * 1000000);
        uint256 nonce = OutrightBetV1(address(outrightBet)).getNonce(customer);
        bytes32 ticketHash = OutrightBetTicketFactoryV1.createTicketHash(customer, nonce, source);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerKey, ticketHash);
        OutrightBetV1(address(outrightBet)).placeOutrightBet(
            1,
            abi.encode(
                source,
                Signature.Vrs(v, r, s)
            )
        );
        vm.stopPrank();

        assertEq(IERC20(address(erc20)).balanceOf(customer), customerBalance - 1000000);
        assertEq(IERC20(address(erc20)).balanceOf(licensee), licenseeBalance - 2000000);

        uint256 ticketCount = OutrightBetV1(address(outrightBet)).getTicketCount();
        assertEq(ticketCount, 1);
    }
}
