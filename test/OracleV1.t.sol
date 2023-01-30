// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "test/utils/BaseOracleV1Test.sol";
import "test/utils/EventResultFactoryV1.sol";
import "test/utils/OutrightResultFactoryV1.sol";

contract OracleV1Test is BaseOracleV1Test {
    function testUploadEventResult() public {
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
    }

    function testUploadOutrightResult() public {
        OutrightResultV1.OutrightEvent
            memory bytesResult = OutrightResultFactoryV1
                .createDefaultBytesResult();
        vm.prank(uploader);
        IOracleV1(address(oracle)).uploadOutrightResult(
            1,
            abi.encode(bytesResult)
        );
        Status.OutrightTeamStatus status;
        uint256 deadHeat;
        (status, deadHeat) = IOracleV1(address(oracle)).getOutrightResult(1, 1);
        assertEq(uint8(status), uint8(Status.OutrightTeamStatus.Won));
        assertEq(deadHeat, 2);
        (status, deadHeat) = IOracleV1(address(oracle)).getOutrightResult(1, 2);
        assertEq(uint8(status), uint8(Status.OutrightTeamStatus.Lost));
        assertEq(deadHeat, 2);
        (status, deadHeat) = IOracleV1(address(oracle)).getOutrightResult(1, 3);
        assertEq(uint8(status), uint8(Status.OutrightTeamStatus.Lost));
        assertEq(deadHeat, 2);
        (status, deadHeat) = IOracleV1(address(oracle)).getOutrightResult(1, 4);
        assertEq(uint8(status), uint8(Status.OutrightTeamStatus.Won));
        assertEq(deadHeat, 2);
        (status, deadHeat) = IOracleV1(address(oracle)).getOutrightResult(1, 5);
        assertEq(uint8(status), uint8(Status.OutrightTeamStatus.Lost));
        assertEq(deadHeat, 2);
    }

    function testSetEventResultEngine() public {
        vm.expectRevert("Ownable: caller is not the owner");
        IOracleV1(address(oracle)).setEventResultEngine(
            3,
            keccak256(abi.encode("777"))
        );
        vm.prank(owner);
        IOracleV1(address(oracle)).setEventResultEngine(
            3,
            keccak256(abi.encode("777"))
        );
    }

    function testSetOutrightResultEngine() public {
        vm.expectRevert("Ownable: caller is not the owner");
        IOracleV1(address(oracle)).setOutrightResultEngine(
            3,
            keccak256(abi.encode("777"))
        );
        vm.prank(owner);
        IOracleV1(address(oracle)).setOutrightResultEngine(
            3,
            keccak256(abi.encode("777"))
        );
    }

    function testSetUploader() public {
        vm.expectRevert("Ownable: caller is not the owner");
        IOracleV1(address(oracle)).setUploader(uploader);
        vm.prank(owner);
        IOracleV1(address(oracle)).setUploader(uploader);
    }

    function testGetEventStatus() public {
        EventResultV1.Event memory bytesResult = EventResultFactoryV1
            .createDefaultEventResult();
        vm.prank(uploader);
        IOracleV1(address(oracle)).uploadEventResult(
            1,
            abi.encode(bytesResult)
        );
        Status.ResultStatus status;
        status = IOracleV1(address(oracle)).getEventStatus(1);
        assertEq(uint8(status), uint8(Status.ResultStatus.Completed));
    }

    function testGetScore() public {
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
    }

    function testGetResultHash() public {
        EventResultV1.Event memory bytesResult = EventResultFactoryV1
            .createDefaultEventResult();
        vm.prank(uploader);
        IOracleV1(address(oracle)).uploadEventResult(
            1,
            abi.encode(bytesResult)
        );
        bytes32 resultHash = IOracleV1(address(oracle)).getResultHash(
            1,
            1,
            1,
            0
        );
        assertEq(resultHash, keccak256(abi.encode("1:1")));
    }

    function testGetOutrightResult() public {
        OutrightResultV1.OutrightEvent
            memory bytesResult = OutrightResultFactoryV1
                .createDefaultBytesResult();
        vm.prank(uploader);
        IOracleV1(address(oracle)).uploadOutrightResult(
            1,
            abi.encode(bytesResult)
        );

        Status.OutrightTeamStatus status;
        uint256 deadHeat;
        (status, deadHeat) = IOracleV1(address(oracle)).getOutrightResult(1, 1);
        assertEq(uint8(status), uint8(Status.OutrightTeamStatus.Won));
        assertEq(deadHeat, 2);
        (status, deadHeat) = IOracleV1(address(oracle)).getOutrightResult(1, 2);
        assertEq(uint8(status), uint8(Status.OutrightTeamStatus.Lost));
        assertEq(deadHeat, 2);
        (status, deadHeat) = IOracleV1(address(oracle)).getOutrightResult(1, 3);
        assertEq(uint8(status), uint8(Status.OutrightTeamStatus.Lost));
        assertEq(deadHeat, 2);
        (status, deadHeat) = IOracleV1(address(oracle)).getOutrightResult(1, 4);
        assertEq(uint8(status), uint8(Status.OutrightTeamStatus.Won));
        assertEq(deadHeat, 2);
        (status, deadHeat) = IOracleV1(address(oracle)).getOutrightResult(1, 5);
        assertEq(uint8(status), uint8(Status.OutrightTeamStatus.Lost));
        assertEq(deadHeat, 2);
    }

    function testGetEventResultEngine() public {
        bytes memory response = IOracleV1(address(oracle)).getEventResultBytes(
            2
        );
        assertEq(response, bytes(""));
    }

    function testGetOutrightResultEngine() public {
        bytes memory response = IOracleV1(address(oracle))
            .getOutrightResultBytes(2);
        assertEq(response, bytes(""));
    }

    function testGetUploader() public {
        address response = IOracleV1(address(oracle)).getUploader();
        assertEq(response, uploader);
    }
}
