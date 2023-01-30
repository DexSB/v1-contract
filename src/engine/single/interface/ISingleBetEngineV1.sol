// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/Receipt.sol";
import "src/lib/Settlement.sol";

interface ISingleBetEngineV1 {
    function settleBet(
        uint256 eventId,
        address oracle,
        bytes calldata ticketBytes
    )
        external
        view
        returns (Settlement.SettlementV1 memory settlement);
    
    function processTicket(
        address signer,
        uint nonce,
        bytes calldata sourceTicketBytes
    ) external view returns (Receipt.BetReceiptV1 memory, bytes memory);

    function rejectBet(
        bytes calldata ticketBytes
    ) external view returns (Settlement.ERC20PaymentV1[] memory);
}
