// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

library BetType {
    uint16 constant FTHandicap = 1;
    uint16 constant FTOddEven = 2;
    uint16 constant FTOverUnder = 3;
    uint16 constant FT1x2 = 5;
    uint16 constant HTHandicap = 7;
    uint16 constant HTOverUnder = 8;
    uint16 constant HTOddEven = 12;
    uint16 constant HT1x2 = 15;
    uint16 constant FTMoneyline = 20;
    uint16 constant HTMoneyline = 21;
    uint16 constant FTGameHandicap = 153;
    uint16 constant FTCorrectScore = 413;
    uint16 constant QuarterHandicap = 609;
    uint16 constant QuarterOverUnder = 610;
    uint16 constant QuarterOddEven = 611;
    uint16 constant QuarterMoneyline = 612;
}
