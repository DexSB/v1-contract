// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/single/BytesTicket.sol";
import "src/lib/Status.sol";

interface ISingleBetV1 {
    event SingleBetPlaced(uint256 transId, address customer);
    event SingleTicketSettled(
        uint256 transId,
        address customer,
        address token,
        uint256 amountToCustomer,
        Status.TicketStatus status
    );
    event SingleBetSettlementNull(
        uint256 transId
    );

    function settleBet(
        uint256 eventId,
        uint256[] calldata transIds
    ) external;

    function placeBet(
        uint256 version,
        bytes memory data
    ) external;

    function rejectBet(
        uint256[] memory transIds
    ) external;

    function setTicketEngine(uint256 version, address engineAddress) external;

    function setRejecter(address newSigner) external;

    function setSigner(address newRejecter) external;

    function setSettler(address newSettler) external;

    function setOracle(address newOracle) external;

    function pause() external;

    function unpause() external;

    function getNonce(address customer) external view returns (uint);

    function getBet(
        uint256 transId
    ) external view returns (BytesTicket.SingleBetTicketV1 memory);

    function getTicketEngine(uint256 version) external view returns (address);

    function getRejecter() external view returns (address);

    function getSigner() external view returns (address);

    function getSettler() external view returns (address);

    function getOracle() external view returns (address);

    function getTicketCount() external view returns (uint256);
}
