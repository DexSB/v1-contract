// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/BetType.sol";
import "src/lib/SettleCondition.sol";

library SettleConditionsHandler {
    function getConditions(
        uint32 betType,
        bytes32 resultHash
    ) internal pure returns (bytes32[] memory conditions) {
        conditions = new bytes32[](3);
        if (betType == BetType.FTHandicap) {
            conditions[0] = SettleCondition.LowerCaseH;// h
            conditions[1] = SettleCondition.LowerCaseA;// a
        }
        else if (betType == BetType.FTOddEven) {
            conditions[0] = SettleCondition.LowerCaseH;// h
            conditions[1] = SettleCondition.LowerCaseA;// a
        }
        else if (betType == BetType.FTOverUnder) {
            conditions[0] = SettleCondition.LowerCaseH;// h
            conditions[1] = SettleCondition.LowerCaseA;// a
        }
        else if (betType == BetType.FT1x2) {
            conditions[0] = SettleCondition.String1;// 1
            conditions[1] = SettleCondition.LowerCaseX;// x
            conditions[2] = SettleCondition.String2;// 2
        }
        else if (betType == BetType.HTHandicap) {
            conditions[0] = SettleCondition.LowerCaseH;// h
            conditions[1] = SettleCondition.LowerCaseA;// a
        }
        else if (betType == BetType.HTOverUnder) {
            conditions[0] = SettleCondition.LowerCaseH;// h
            conditions[1] = SettleCondition.LowerCaseA;// a
        }
        else if (betType == BetType.HTOddEven) {
            conditions[0] = SettleCondition.LowerCaseH;// h
            conditions[1] = SettleCondition.LowerCaseA;// a
        }
        else if (betType == BetType.HT1x2) {
            conditions[0] = SettleCondition.String1;// 1
            conditions[1] = SettleCondition.LowerCaseX;// x
            conditions[2] = SettleCondition.String2;// 2
        }
        else if (betType == BetType.FTMoneyline) {
            conditions[0] = SettleCondition.LowerCaseH;// h
            conditions[1] = SettleCondition.LowerCaseA;// a
        }
        else if (betType == BetType.HTMoneyline) {
            conditions[0] = SettleCondition.LowerCaseH;// h
            conditions[1] = SettleCondition.LowerCaseA;// a
        }
        else if (betType == BetType.FTGameHandicap) {
            conditions[0] = SettleCondition.LowerCaseH;// h
            conditions[1] = SettleCondition.LowerCaseA;// a
        }
        else if (betType == BetType.FTCorrectScore) {
            conditions[0] = resultHash;
        }
        else if (betType == BetType.QuarterHandicap) {
            conditions[0] = SettleCondition.LowerCaseH;// h
            conditions[1] = SettleCondition.LowerCaseA;// a
        }
        else if (betType == BetType.QuarterOverUnder) {
            conditions[0] = SettleCondition.LowerCaseO;// o
            conditions[1] = SettleCondition.LowerCaseU;// u
        }
        else if (betType == BetType.QuarterOddEven) {
            conditions[0] = SettleCondition.LowerCaseO;// o
            conditions[1] = SettleCondition.LowerCaseE;// e
        }
        else if (betType == BetType.QuarterMoneyline) {
            conditions[0] = SettleCondition.LowerCaseH;// h
            conditions[1] = SettleCondition.LowerCaseA;// a
        }
    }
}
