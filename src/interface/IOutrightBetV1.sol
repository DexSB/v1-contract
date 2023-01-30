// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/outright/BytesTicket.sol";
import "src/lib/Status.sol";

interface IOutrightBetV1 {
    event OutrightBetPlaced(uint256 transId, address customer);
    event OutrightTicketSettled(
        uint256 transId,
        address customer,
        address token,
        uint256 amountToCustomer,
        Status.TicketStatus status
    );
    event OutrightBetSettlementNull(
        uint256 transId
    );

    function settleBet(
        uint256 leagueId,
        uint256[] memory transIds
    ) external;

    function placeOutrightBet(
        uint256 version,
        bytes memory data
    ) external;

    function rejectBet(
        uint256[] memory transIds
    ) external;

    function pause() external;

    function unpause() external;

    function setRejecter(address newRejecter) external;

    function setTicketEngine(uint256 version, address engineAddress) external;

    function setSigner(address newSigner) external;

    function setSettler(address newSettler) external;

    function setOracle(address newOracle) external;

    function getNonce(address customer) external view returns (uint);

    function getBet(uint256 transId) external view returns (BytesTicket.OutrightBetTicketV1 memory);

    function getTicketEngine(uint256 version) external view returns (address);

    function getRejecter() external view returns (address);

    function getSigner() external view returns (address);

    function getSettler() external view returns (address);

    function getOracle() external view returns (address);

    function getTicketCount() external view returns (uint256);
}
