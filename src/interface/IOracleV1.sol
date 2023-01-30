// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/Status.sol";

interface IOracleV1 {
    function uploadEventResult(
        uint256 version,
        bytes memory resultBytes
    ) external;

    function uploadOutrightResult(
        uint256 version,
        bytes memory resultBytes
    ) external;

    function setEventResultEngine(uint256 version, bytes32 modelHash) external;

    function setOutrightResultEngine(
        uint256 version,
        bytes32 modelHash
    ) external;

    function setUploader(address newUploader) external;

    function getEventStatus(
        uint256 eventId
    ) external view returns (Status.ResultStatus);

    function getScore(
        uint256 eventId,
        uint256 sportType,
        uint16 betType,
        uint8 resource1
    ) external view returns (uint256, uint256);

    function getResultHash(
        uint256 eventId,
        uint256 sportType,
        uint16 betType,
        uint8 resource1
    ) external view returns (bytes32);

    function getOutrightResult(
        uint256 leagueId,
        uint256 teamId
    ) external view returns (Status.OutrightTeamStatus, uint256);

    function getEventResultEngine(
        uint256 version
    ) external view returns (bytes32);

    function getOutrightResultEngine(
        uint256 version
    ) external view returns (bytes32);

    function getEventResultBytes(
        uint256 eventId
    ) external view returns (bytes memory);

    function getOutrightResultBytes(
        uint256 eventId
    ) external view returns (bytes memory);

    function getUploader() external view returns (address);
}
