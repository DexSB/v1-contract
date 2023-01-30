// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/interface/IOracleV1.sol";
import "src/lib/oracle/BytesResult.sol";
import "src/lib/oracle/BytesEventMap.sol";
import "src/lib/oracle/BytesOutrightMap.sol";
import "src/lib/oracle/EventHandlerV1.sol";
import "src/lib/oracle/EventHandlerV2.sol";
import "src/lib/oracle/OutrightHandlerV1.sol";
import "src/utils/BaseOwnable.sol";

contract OracleV1 is BaseOwnable, IOracleV1 {
    using BytesEventMap for BytesEventMap.EventResultMap;
    using BytesOutrightMap for BytesOutrightMap.OutrightResultMap;

    address private uploader;

    BytesEventMap.EventResultMap eventResults;
    BytesOutrightMap.OutrightResultMap outrightResults;

    mapping(uint256 => bytes32) eventVersionMap;
    mapping(uint256 => bytes32) outrightVersionMap;

    function initialize(address _uploader) public initializer {
        BaseOwnable.initialize();
        uploader = _uploader;
        eventVersionMap[
            1
        ] = 0xb2114c5e50a6e3b0a562e1ca3d1dd277439cdeab1ea233af5a18f4e34fb3d55a;
        eventVersionMap[
            2
        ] = 0xb0d9989951bcc5ede3f40b1eb13528570a4bdab58c2c93364727037fbcd7bb87;
        outrightVersionMap[
            1
        ] = 0x668ca07e9cd6f44b1a02428018154dc9f40eb765e7d7102537c8d3627169145a;
    }

    // this function should only be called to upload result of event,
    // maintainer have to be aware of don't mix it with ouright result
    function uploadEventResult(
        uint256 version,
        bytes memory resultBytes
    ) external override {
        require(
            msg.sender == uploader,
            "CustomErrors: caller is not the uploader"
        );
        require(eventVersionMap[version] != 0, "CustomErrors: invalid version");

        uint256 eventId;
        if (version == 1) {
            eventId = EventHandlerV1.getEventId(resultBytes);
        } else if (version == 2) {
            eventId = EventHandlerV2.getEventId(resultBytes);
        }

        (bool isExist, ) = eventResults.tryGet(eventId);
        if (isExist) {
            eventResults.remove(eventId);
        }

        BytesResult.EventResultV1 memory bytesResult = BytesResult
            .EventResultV1(version, resultBytes);
        eventResults.set(eventId, bytesResult);
    }

    // this function should only be called to upload result of outright,
    // maintainer have to be aware of don't mix it with event result
    function uploadOutrightResult(
        uint256 version,
        bytes memory resultBytes
    ) external override {
        require(
            msg.sender == uploader,
            "CustomErrors: caller is not the uploader"
        );
        require(
            outrightVersionMap[version] != 0,
            "CustomErrors: invalid version"
        );

        uint256 leagueId;
        if (version == 1) {
            leagueId = OutrightHandlerV1.getLeagueId(resultBytes);
        }

        (bool isExist, ) = outrightResults.tryGet(leagueId);

        if (isExist) {
            outrightResults.remove(leagueId);
        }
        BytesResult.OutrightResultV1 memory bytesResult = BytesResult
            .OutrightResultV1(version, resultBytes);
        outrightResults.set(leagueId, bytesResult);
    }

    function setEventResultEngine(
        uint256 version,
        bytes32 modelHash
    ) external override onlyOwner {
        eventVersionMap[version] = modelHash;
    }

    function setOutrightResultEngine(
        uint256 version,
        bytes32 modelHash
    ) external override onlyOwner {
        outrightVersionMap[version] = modelHash;
    }

    function setUploader(address newUploader) external override onlyOwner {
        uploader = newUploader;
    }

    function getEventStatus(
        uint256 eventId
    ) external view override returns (Status.ResultStatus status) {
        (bool isExist, BytesResult.EventResultV1 memory result) = eventResults
            .tryGet(eventId);

        require(isExist, "CustomErrors: result is not uploaded");
        if (result.version == 1) {
            return EventHandlerV1.getEventStatus(result.resultBytes);
        } else if (result.version == 2) {
            return EventHandlerV2.getEventStatus(result.resultBytes);
        }
    }

    function getScore(
        uint256 eventId,
        uint256 sportType,
        uint16 betType,
        uint8 resource1
    ) external view override returns (uint256 homeScore, uint256 awayScore) {
        (bool isExist, BytesResult.EventResultV1 memory result) = eventResults
            .tryGet(eventId);

        require(isExist, "CustomErrors: result is not uploaded");
        if (result.version == 1) {
            return
                EventHandlerV1.getScore(betType, resource1, result.resultBytes);
        } else if (result.version == 2) {
            return
                EventHandlerV2.getScore(
                    sportType,
                    betType,
                    resource1,
                    result.resultBytes
                );
        }
    }

    function getResultHash(
        uint256 eventId,
        uint256 sportType,
        uint16 betType,
        uint8 resource1
    ) external view override returns (bytes32 resultHash) {
        (bool isExist, BytesResult.EventResultV1 memory result) = eventResults
            .tryGet(eventId);

        require(isExist, "CustomErrors: result is not uploaded");
        if (result.version == 1) {
            return
                EventHandlerV1.getResultHash(
                    betType,
                    resource1,
                    result.resultBytes
                );
        } else if (result.version == 2) {
            return
                EventHandlerV2.getResultHash(
                    sportType,
                    betType,
                    resource1,
                    result.resultBytes
                );
        }
    }

    function getOutrightResult(
        uint256 leagueId,
        uint256 teamId
    )
        external
        view
        override
        returns (Status.OutrightTeamStatus status, uint256 deadHeat)
    {
        (
            bool isExist,
            BytesResult.OutrightResultV1 memory result
        ) = outrightResults.tryGet(leagueId);

        require(isExist, "CustomErrors: result is not uploaded");
        if (result.version == 1) {
            return
                OutrightHandlerV1.getOutrightResult(teamId, result.resultBytes);
        }
    }

    function getEventResultEngine(
        uint256 version
    ) external view override returns (bytes32) {
        return eventVersionMap[version];
    }

    function getOutrightResultEngine(
        uint256 version
    ) external view override returns (bytes32) {
        return outrightVersionMap[version];
    }

    function getEventResultBytes(
        uint256 eventId
    ) external view override returns (bytes memory) {
        (, BytesResult.EventResultV1 memory result) = eventResults.tryGet(
            eventId
        );
        return result.resultBytes;
    }

    function getOutrightResultBytes(
        uint256 eventId
    ) external view override returns (bytes memory) {
        (, BytesResult.OutrightResultV1 memory result) = outrightResults.tryGet(
            eventId
        );
        return result.resultBytes;
    }

    function getUploader() external view override returns (address) {
        return uploader;
    }
}
