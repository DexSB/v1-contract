// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/EnumerableSet.sol";
import "src/lib/oracle/BytesResult.sol";

library BytesOutrightMap {
    using EnumerableSet for EnumerableSet.UintSet;

    struct OutrightResultMap {
        EnumerableSet.UintSet _keys;
        mapping(uint256 => bytes) _values;
    }

    function set(
        OutrightResultMap storage map,
        uint256 key,
        BytesResult.OutrightResultV1 memory value
    ) internal returns (bool) {
        map._values[key] = abi.encode(value);
        return map._keys.add(key);
    }

    function remove(
        OutrightResultMap storage map,
        uint256 key
    ) internal returns (bool) {
        delete map._values[key];
        return map._keys.remove(key);
    }

    function contains(
        OutrightResultMap storage map,
        uint256 key
    ) internal view returns (bool) {
        return map._keys.contains(key);
    }

    function length(
        OutrightResultMap storage map
    ) internal view returns (uint256) {
        return map._keys.length();
    }

    function at(
        OutrightResultMap storage map,
        uint256 index
    ) internal view returns (uint256, BytesResult.OutrightResultV1 memory) {
        uint256 key = map._keys.at(index);
        return (
            key,
            abi.decode(
                map._values[key],
                (BytesResult.OutrightResultV1)
            )
        );
    }

    function tryGet(
        OutrightResultMap storage map,
        uint256 key
    ) internal view returns (bool, BytesResult.OutrightResultV1 memory result) {
        bytes memory value = map._values[key];
        if (keccak256(value) == keccak256(bytes(""))) {
            return (contains(map, key), result);
        } else {
            return (
                true,
                abi.decode(
                    map._values[key],
                    (BytesResult.OutrightResultV1)
                )
            );
        }
    }
}
