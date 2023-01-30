// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/EnumerableSet.sol";
import "src/lib/single/BytesTicket.sol";

library BytesTicketMap {
    using EnumerableSet for EnumerableSet.UintSet;

    struct SingleBetTicketMapV1 {
        EnumerableSet.UintSet _keys;
        mapping(uint256 => bytes) _values;
    }

    function set(
        SingleBetTicketMapV1 storage map,
        uint256 key,
        BytesTicket.SingleBetTicketV1 memory value
    ) internal returns (bool) {
        map._values[key] = abi.encode(value);
        return map._keys.add(key);
    }

    function remove(
        SingleBetTicketMapV1 storage map,
        uint256 key
    ) internal returns (bool) {
        delete map._values[key];
        return map._keys.remove(key);
    }

    function contains(
        SingleBetTicketMapV1 storage map,
        uint256 key
    ) internal view returns (bool) {
        return map._keys.contains(key);
    }

    function length(
        SingleBetTicketMapV1 storage map
    ) internal view returns (uint256) {
        return map._keys.length();
    }

    function at(
        SingleBetTicketMapV1 storage map,
        uint256 index
    ) internal view returns (uint256, BytesTicket.SingleBetTicketV1 memory) {
        uint256 key = map._keys.at(index);
        return (
            key,
            abi.decode(
                map._values[key],
                (BytesTicket.SingleBetTicketV1)
            )
        );
    }

    function tryGet(
        SingleBetTicketMapV1 storage map,
        uint256 key
    ) internal view returns (bool, BytesTicket.SingleBetTicketV1 memory result) {
        bytes memory value = map._values[key];
        if (keccak256(value) == keccak256(bytes(""))) {
            return (contains(map, key), result);
        } else {
            return (
                true,
                abi.decode(
                    map._values[key],
                    (BytesTicket.SingleBetTicketV1)
                )
            );
        }
    }
}
