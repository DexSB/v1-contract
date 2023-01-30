// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "test/utils/BaseSingleBetV1Test.sol";
import "test/utils/SingleBetTicketFactoryV1.sol";
import "test/utils/EventResultFactoryV1.sol";

contract SingleBetV1Test is BaseSingleBetV1Test {
    function testSettleBet() public {
        uint256 customerBalance = IERC20(address(erc20)).balanceOf(customer);
        uint256 licenseeBalance = IERC20(address(erc20)).balanceOf(licensee);

        SingleBetTicketV1.SourceSingleBet
            memory source = SingleBetTicketFactoryV1.createDefaultTicket(
                customer,
                licensee,
                address(erc20)
            );

        vm.prank(licensee);
        IERC20(address(erc20)).approve(address(singleBet), 1000000 * 1000000);

        vm.startPrank(customer);
        IERC20(address(erc20)).approve(address(singleBet), 1000000 * 1000000);
        uint256 nonce = SingleBetV1(address(singleBet)).getNonce(customer);
        bytes32 ticketHash = SingleBetTicketFactoryV1.createTicketHash(
            customer,
            nonce,
            source
        );
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerKey, ticketHash);
        SingleBetV1(address(singleBet)).placeBet(
            1,
            abi.encode(source, Signature.Vrs(v, r, s))
        );
        vm.stopPrank();

        assertEq(
            IERC20(address(erc20)).balanceOf(customer),
            customerBalance - 1000000
        );
        assertEq(
            IERC20(address(erc20)).balanceOf(licensee),
            licenseeBalance - 2000000
        );

        EventResultV1.Event memory bytesResult = EventResultFactoryV1
            .createDefaultEventResult();
        vm.prank(uploader);
        IOracleV1(address(oracle)).uploadEventResult(
            1,
            abi.encode(bytesResult)
        );
        (uint256 homeScore, uint256 awayScore) = IOracleV1(address(oracle))
            .getScore(1, 1, 1, 0);
        assertEq(homeScore, 1);
        assertEq(awayScore, 1);

        uint256[] memory transIds = new uint256[](1);
        transIds[0] = 1;
        vm.expectRevert("CustomErrors: caller is not the settler");
        SingleBetV1(address(singleBet)).settleBet(1, transIds);
        vm.prank(settler);
        SingleBetV1(address(singleBet)).settleBet(1, transIds);
        assertEq(
            IERC20(address(erc20)).balanceOf(customer),
            customerBalance + 2000000
        );
        assertEq(
            IERC20(address(erc20)).balanceOf(licensee),
            licenseeBalance - 2000000
        );
    }

    function testSettleBetWithFreeBetToken() public {
        uint256 customerBalance = IERC20(address(erc20)).balanceOf(customer);
        uint256 customerFreeBetBalance = IERC20(address(freeBetErc20)).balanceOf(customer);
        uint256 licenseeBalance = IERC20(address(erc20)).balanceOf(licensee);

        SingleBetTicketV1.SourceSingleBet
            memory source = SingleBetTicketFactoryV1.createDefaultTicket(
                customer,
                licensee,
                address(erc20)
            );
        source.token = address(freeBetErc20);

        vm.prank(licensee);
        IERC20(address(erc20)).approve(address(singleBet), 1000000 * 1000000);

        vm.startPrank(customer);
        IERC20(address(freeBetErc20)).approve(address(singleBet), 1000000 * 1000000);
        uint256 nonce = SingleBetV1(address(singleBet)).getNonce(customer);
        bytes32 ticketHash = SingleBetTicketFactoryV1.createTicketHash(
            customer,
            nonce,
            source
        );
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerKey, ticketHash);
        SingleBetV1(address(singleBet)).placeBet(
            1,
            abi.encode(source, Signature.Vrs(v, r, s))
        );
        vm.stopPrank();

        assertEq(
            IERC20(address(erc20)).balanceOf(customer),
            customerBalance
        );
        assertEq(
            IERC20(address(freeBetErc20)).balanceOf(customer),
            customerFreeBetBalance - 1000000
        );
        assertEq(
            IERC20(address(erc20)).balanceOf(licensee),
            licenseeBalance - 2000000
        );

        EventResultV1.Event memory bytesResult = EventResultFactoryV1
            .createDefaultEventResult();
        vm.prank(uploader);
        IOracleV1(address(oracle)).uploadEventResult(
            1,
            abi.encode(bytesResult)
        );
        (uint256 homeScore, uint256 awayScore) = IOracleV1(address(oracle))
            .getScore(1, 1, 1, 0);
        assertEq(homeScore, 1);
        assertEq(awayScore, 1);

        uint256[] memory transIds = new uint256[](1);
        transIds[0] = 1;
        vm.expectRevert("CustomErrors: caller is not the settler");
        SingleBetV1(address(singleBet)).settleBet(1, transIds);
        vm.prank(settler);
        SingleBetV1(address(singleBet)).settleBet(1, transIds);
        assertEq(
            IERC20(address(freeBetErc20)).balanceOf(customer),
            customerFreeBetBalance - 1000000
        );
        assertEq(
            IERC20(address(erc20)).balanceOf(customer),
            customerBalance + 2000000
        );
        assertEq(
            IERC20(address(erc20)).balanceOf(licensee),
            licenseeBalance - 2000000
        );
    }

    function testSettleNoResultBet() public {
        uint256 customerBalance = IERC20(address(erc20)).balanceOf(customer);
        uint256 licenseeBalance = IERC20(address(erc20)).balanceOf(licensee);

        SingleBetTicketV1.SourceSingleBet
            memory source = SingleBetTicketFactoryV1.createDefaultTicket(
                customer,
                licensee,
                address(erc20)
            );

        vm.prank(licensee);
        IERC20(address(erc20)).approve(address(singleBet), 1000000 * 1000000);

        vm.startPrank(customer);
        IERC20(address(erc20)).approve(address(singleBet), 1000000 * 1000000);
        uint256 nonce = SingleBetV1(address(singleBet)).getNonce(customer);
        bytes32 ticketHash = SingleBetTicketFactoryV1.createTicketHash(
            customer,
            nonce,
            source
        );
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerKey, ticketHash);
        SingleBetV1(address(singleBet)).placeBet(
            1,
            abi.encode(source, Signature.Vrs(v, r, s))
        );
        vm.stopPrank();

        assertEq(
            IERC20(address(erc20)).balanceOf(customer),
            customerBalance - 1000000
        );
        assertEq(
            IERC20(address(erc20)).balanceOf(licensee),
            licenseeBalance - 2000000
        );

        uint256[] memory transIds = new uint256[](1);
        transIds[0] = 1;
        vm.expectRevert("CustomErrors: caller is not the settler");
        SingleBetV1(address(singleBet)).settleBet(1, transIds);
        vm.prank(settler);
        vm.expectRevert("CustomErrors: result is not uploaded");
        SingleBetV1(address(singleBet)).settleBet(1, transIds);
        assertEq(
            IERC20(address(erc20)).balanceOf(customer),
            customerBalance - 1000000
        );
        assertEq(
            IERC20(address(erc20)).balanceOf(licensee),
            licenseeBalance - 2000000
        );
    }

    function testPlaceBet() public {
        uint256 customerBalance = IERC20(address(erc20)).balanceOf(customer);
        uint256 licenseeBalance = IERC20(address(erc20)).balanceOf(licensee);

        SingleBetTicketV1.SourceSingleBet
            memory source = SingleBetTicketFactoryV1.createDefaultTicket(
                customer,
                licensee,
                address(erc20)
            );

        vm.prank(licensee);
        IERC20(address(erc20)).approve(address(singleBet), 1000000 * 1000000);

        vm.startPrank(customer);
        IERC20(address(erc20)).approve(address(singleBet), 1000000 * 1000000);
        uint256 nonce = SingleBetV1(address(singleBet)).getNonce(customer);
        bytes32 ticketHash = SingleBetTicketFactoryV1.createTicketHash(
            customer,
            nonce,
            source
        );
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerKey, ticketHash);
        SingleBetV1(address(singleBet)).placeBet(
            1,
            abi.encode(source, Signature.Vrs(v, r, s))
        );

        assertEq(
            IERC20(address(erc20)).balanceOf(customer),
            customerBalance - 1000000
        );
        assertEq(
            IERC20(address(erc20)).balanceOf(licensee),
            licenseeBalance - 2000000
        );
    }

    function testPlaceBetWithFreeBetToken() public {
        uint256 customerBalance = IERC20(address(erc20)).balanceOf(customer);
        uint256 customerFreeBetBalance = IERC20(address(freeBetErc20)).balanceOf(customer);
        uint256 licenseeBalance = IERC20(address(erc20)).balanceOf(licensee);

        SingleBetTicketV1.SourceSingleBet
            memory source = SingleBetTicketFactoryV1.createDefaultTicket(
                customer,
                licensee,
                address(erc20)
            );
        source.token = address(freeBetErc20);

        vm.prank(licensee);
        IERC20(address(erc20)).approve(address(singleBet), 1000000 * 1000000);

        vm.startPrank(customer);
        IERC20(address(erc20)).approve(address(singleBet), 1000000 * 1000000);
        IERC20(address(freeBetErc20)).approve(address(singleBet), 1000000 * 1000000);
        uint256 nonce = SingleBetV1(address(singleBet)).getNonce(customer);
        bytes32 ticketHash = SingleBetTicketFactoryV1.createTicketHash(
            customer,
            nonce,
            source
        );
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerKey, ticketHash);
        SingleBetV1(address(singleBet)).placeBet(
            1,
            abi.encode(source, Signature.Vrs(v, r, s))
        );

        assertEq(
            IERC20(address(erc20)).balanceOf(customer),
            customerBalance
        );
        assertEq(
            IERC20(address(freeBetErc20)).balanceOf(customer),
            customerFreeBetBalance - 1000000
        );
        assertEq(
            IERC20(address(erc20)).balanceOf(licensee),
            licenseeBalance - 2000000
        );
    }

    function testRejectBet() public {
        uint256 customerBalance = IERC20(address(erc20)).balanceOf(customer);
        uint256 licenseeBalance = IERC20(address(erc20)).balanceOf(licensee);

        SingleBetTicketV1.SourceSingleBet
            memory source = SingleBetTicketFactoryV1.createDefaultTicket(
                customer,
                licensee,
                address(erc20)
            );

        vm.prank(licensee);
        IERC20(address(erc20)).approve(address(singleBet), 1000000 * 1000000);

        vm.startPrank(customer);
        IERC20(address(erc20)).approve(address(singleBet), 1000000 * 1000000);
        uint256 nonce = SingleBetV1(address(singleBet)).getNonce(customer);
        bytes32 ticketHash = SingleBetTicketFactoryV1.createTicketHash(
            customer,
            nonce,
            source
        );
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerKey, ticketHash);
        SingleBetV1(address(singleBet)).placeBet(
            1,
            abi.encode(source, Signature.Vrs(v, r, s))
        );
        vm.stopPrank();

        assertEq(
            IERC20(address(erc20)).balanceOf(customer),
            customerBalance - 1000000
        );
        assertEq(
            IERC20(address(erc20)).balanceOf(licensee),
            licenseeBalance - 2000000
        );

        uint256[] memory transIds = new uint256[](1);
        transIds[0] = 1;
        vm.expectRevert("CustomErrors: caller is not the rejecter");
        SingleBetV1(address(singleBet)).rejectBet(transIds);
        vm.prank(rejecter);
        SingleBetV1(address(singleBet)).rejectBet(transIds);
        assertEq(IERC20(address(erc20)).balanceOf(customer), customerBalance);
        assertEq(IERC20(address(erc20)).balanceOf(licensee), licenseeBalance);
    }

    function testSetTicketEngine() public {
        vm.expectRevert("Ownable: caller is not the owner");
        SingleBetV1(address(singleBet)).setTicketEngine(2, address(0));
        vm.prank(owner);
        SingleBetV1(address(singleBet)).setTicketEngine(2, address(0));
    }

    function testSetRejecter() public {
        vm.expectRevert("Ownable: caller is not the owner");
        SingleBetV1(address(singleBet)).setRejecter(rejecter);
        vm.prank(owner);
        SingleBetV1(address(singleBet)).setRejecter(rejecter);
    }

    function testSetSigner() public {
        vm.expectRevert("Ownable: caller is not the owner");
        SingleBetV1(address(singleBet)).setSigner(signer);
        vm.prank(owner);
        SingleBetV1(address(singleBet)).setSigner(signer);
    }

    function testSetSettler() public {
        vm.expectRevert("Ownable: caller is not the owner");
        SingleBetV1(address(singleBet)).setSettler(settler);
        vm.prank(owner);
        SingleBetV1(address(singleBet)).setSettler(settler);
    }

    function testSetOracle() public {
        vm.expectRevert("Ownable: caller is not the owner");
        SingleBetV1(address(singleBet)).setOracle(address(oracle));
        vm.prank(owner);
        SingleBetV1(address(singleBet)).setOracle(address(oracle));
    }

    function testPause() public {
        vm.expectRevert("Ownable: caller is not the owner");
        SingleBetV1(address(singleBet)).pause();
        vm.prank(owner);
        SingleBetV1(address(singleBet)).pause();
    }

    function testUnpause() public {
        vm.expectRevert("Ownable: caller is not the owner");
        SingleBetV1(address(singleBet)).unpause();
        vm.startPrank(owner);
        vm.expectRevert("Pausable: not paused");
        SingleBetV1(address(singleBet)).unpause();
        SingleBetV1(address(singleBet)).pause();
        SingleBetV1(address(singleBet)).unpause();
        vm.stopPrank();
    }

    function testGetNonce() public {
        uint256 customerBalance = IERC20(address(erc20)).balanceOf(customer);
        uint256 licenseeBalance = IERC20(address(erc20)).balanceOf(licensee);

        SingleBetTicketV1.SourceSingleBet
            memory source = SingleBetTicketFactoryV1.createDefaultTicket(
                customer,
                licensee,
                address(erc20)
            );

        vm.prank(licensee);
        IERC20(address(erc20)).approve(address(singleBet), 1000000 * 1000000);

        vm.startPrank(customer);
        IERC20(address(erc20)).approve(address(singleBet), 1000000 * 1000000);
        uint256 nonce = SingleBetV1(address(singleBet)).getNonce(customer);
        assertEq(nonce, 0);
        bytes32 ticketHash = SingleBetTicketFactoryV1.createTicketHash(
            customer,
            nonce,
            source
        );
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerKey, ticketHash);
        SingleBetV1(address(singleBet)).placeBet(
            1,
            abi.encode(source, Signature.Vrs(v, r, s))
        );

        assertEq(
            IERC20(address(erc20)).balanceOf(customer),
            customerBalance - 1000000
        );
        assertEq(
            IERC20(address(erc20)).balanceOf(licensee),
            licenseeBalance - 2000000
        );

        nonce = SingleBetV1(address(singleBet)).getNonce(customer);
        assertEq(nonce, 1);
    }

    function testGetBet() public {
        uint256 customerBalance = IERC20(address(erc20)).balanceOf(customer);
        uint256 licenseeBalance = IERC20(address(erc20)).balanceOf(licensee);

        BytesTicket.SingleBetTicketV1 memory ticket = SingleBetV1(
            address(singleBet)
        ).getBet(1);
        assertEq(ticket.version, 0);

        SingleBetTicketV1.SourceSingleBet
            memory source = SingleBetTicketFactoryV1.createDefaultTicket(
                customer,
                licensee,
                address(erc20)
            );

        vm.prank(licensee);
        IERC20(address(erc20)).approve(address(singleBet), 1000000 * 1000000);

        vm.startPrank(customer);
        IERC20(address(erc20)).approve(address(singleBet), 1000000 * 1000000);
        uint256 nonce = SingleBetV1(address(singleBet)).getNonce(customer);
        assertEq(nonce, 0);
        bytes32 ticketHash = SingleBetTicketFactoryV1.createTicketHash(
            customer,
            nonce,
            source
        );
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerKey, ticketHash);
        SingleBetV1(address(singleBet)).placeBet(
            1,
            abi.encode(source, Signature.Vrs(v, r, s))
        );

        assertEq(
            IERC20(address(erc20)).balanceOf(customer),
            customerBalance - 1000000
        );
        assertEq(
            IERC20(address(erc20)).balanceOf(licensee),
            licenseeBalance - 2000000
        );

        ticket = SingleBetV1(address(singleBet)).getBet(1);
        assertEq(ticket.version, 1);
    }

    function testGetTicketEngine() public {
        address engineAddress = SingleBetV1(address(singleBet)).getTicketEngine(
            1
        );
        assertEq(address(engine), engineAddress);
    }

    function testGetRejecter() public {
        address response = SingleBetV1(address(singleBet)).getRejecter();
        assertEq(rejecter, response);
    }

    function testGetSigner() public {
        address response = SingleBetV1(address(singleBet)).getSigner();
        assertEq(signer, response);
    }

    function testGetSettler() public {
        address response = SingleBetV1(address(singleBet)).getSettler();
        assertEq(settler, response);
    }

    function testGetOracle() public {
        address response = SingleBetV1(address(singleBet)).getOracle();
        assertEq(address(oracle), response);
    }

    function testGetTicketCount() public {
        uint256 customerBalance = IERC20(address(erc20)).balanceOf(customer);
        uint256 licenseeBalance = IERC20(address(erc20)).balanceOf(licensee);

        BytesTicket.SingleBetTicketV1 memory ticket = SingleBetV1(
            address(singleBet)
        ).getBet(1);
        assertEq(ticket.version, 0);

        SingleBetTicketV1.SourceSingleBet
            memory source = SingleBetTicketFactoryV1.createDefaultTicket(
                customer,
                licensee,
                address(erc20)
            );

        vm.prank(licensee);
        IERC20(address(erc20)).approve(address(singleBet), 1000000 * 1000000);

        vm.startPrank(customer);
        IERC20(address(erc20)).approve(address(singleBet), 1000000 * 1000000);
        uint256 nonce = SingleBetV1(address(singleBet)).getNonce(customer);
        assertEq(nonce, 0);
        bytes32 ticketHash = SingleBetTicketFactoryV1.createTicketHash(
            customer,
            nonce,
            source
        );
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerKey, ticketHash);
        SingleBetV1(address(singleBet)).placeBet(
            1,
            abi.encode(source, Signature.Vrs(v, r, s))
        );

        assertEq(
            IERC20(address(erc20)).balanceOf(customer),
            customerBalance - 1000000
        );
        assertEq(
            IERC20(address(erc20)).balanceOf(licensee),
            licenseeBalance - 2000000
        );

        ticket = SingleBetV1(address(singleBet)).getBet(1);
        assertEq(ticket.version, 1);
        vm.stopPrank();

        uint256 ticketCount = SingleBetV1(address(singleBet)).getTicketCount();
        assertEq(ticketCount, 1);
    }
}
