// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/outright/BytesTicket.sol";
import "src/lib/outright/OutrightBetTicketV1.sol";
import "src/lib/Type.sol";
import "openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol";

library OutrightBetTicketFactoryV1 {
    function createDefaultTicket(
        address customer,
        address payoutAddress,
        address token
    )
        internal
        pure
        returns (OutrightBetTicketV1.SourceOutrightBet memory)
    {
        return OutrightBetTicketV1.SourceOutrightBet(
            1, 1, 1, Type.OddsType.Decimal,
            300, 1000000, customer, payoutAddress, token,
            Status.TicketStatus.Running,
            0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
        );
    }

    function createTicketHash(
        address customer,
        uint256 nonce,
        OutrightBetTicketV1.SourceOutrightBet memory source
    )
        internal
        pure
        returns (bytes32)
    {
        bytes32 myHash = keccak256(
            abi.encode(
                customer,
                nonce,
                1,
                source
            )
        );

        return ECDSA.toEthSignedMessageHash(myHash);
    }
}
