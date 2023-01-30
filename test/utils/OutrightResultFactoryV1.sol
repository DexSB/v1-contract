// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/oracle/BytesResult.sol";
import "src/lib/oracle/OutrightResultV1.sol";
import "src/lib/Status.sol";

library OutrightResultFactoryV1 {
    function createDefaultBytesResult()
        internal
        pure
        returns (OutrightResultV1.OutrightEvent memory)
    {
        OutrightResultV1.Outright[] memory outrights = new OutrightResultV1.Outright[](4); 
        outrights[0] = OutrightResultV1.Outright(1, Status.OutrightTeamStatus.Won);
        outrights[1] = OutrightResultV1.Outright(2, Status.OutrightTeamStatus.Lost);
        outrights[2] = OutrightResultV1.Outright(3, Status.OutrightTeamStatus.Lost);
        outrights[3] = OutrightResultV1.Outright(4, Status.OutrightTeamStatus.Won);

        return OutrightResultV1.OutrightEvent(
            1, 1, outrights, 2
        );
    }
}
