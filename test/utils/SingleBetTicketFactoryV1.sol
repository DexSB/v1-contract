// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/single/BytesTicket.sol";
import "src/lib/single/SingleBetTicketV1.sol";
import "src/lib/Type.sol";
import "openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol";

library SingleBetTicketFactoryV1 {
    function createDefaultTicket(
        address customer,
        address payoutAddress,
        address token
    )
        internal
        pure
        returns (SingleBetTicketV1.SourceSingleBet memory)
    {
        return SingleBetTicketV1.SourceSingleBet(
            1, 1, 1, 5, "x", 0, 0, Type.OddsType.Decimal,
            300, 1000000, customer, payoutAddress, token, 0, 0,
            0, Status.TicketStatus.Running,
            0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
        );
    }

    function createTicketHash(
        address customer,
        uint256 nonce,
        SingleBetTicketV1.SourceSingleBet memory source
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
