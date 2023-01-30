// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/lib/Status.sol";
import "src/lib/BetType.sol";
import "src/lib/Settlement.sol";

library SettlementHandler {
    function settleSingleBetTicket(
        int256 result,
        bytes32 keyHash,
        uint16 betType,
        bytes32[] memory conditions,
        uint256 payout,
        uint256 stake,
        uint256 hdpFactor
    ) internal pure returns (Status.TicketStatus) {
        Status.TicketStatus status;
        if (
            betType == BetType.FTHandicap ||
            betType == BetType.HTHandicap ||
            betType == BetType.QuarterHandicap ||
            betType == BetType.FTGameHandicap
        ) {
            status = settleHandicap(
                result,
                keyHash,
                conditions,
                payout,
                stake
            );
        } else if (
            betType == BetType.FTOddEven ||
            betType == BetType.HTOddEven ||
            betType == BetType.QuarterOddEven
        ) {
            status = settleOddEven(
                result,
                keyHash,
                conditions,
                payout,
                stake,
                hdpFactor
            );
        } else if (
            betType == BetType.FTOverUnder ||
            betType == BetType.HTOverUnder ||
            betType == BetType.QuarterOverUnder
        ) {
            status = settleOverUnder(
                result,
                keyHash,
                conditions,
                payout,
                stake
            );
        } else if (betType == BetType.FT1x2 || betType == BetType.HT1x2) {
            status = settle1x2(result, keyHash, conditions, payout);
        } else if (
            betType == BetType.FTMoneyline ||
            betType == BetType.HTMoneyline ||
            betType == BetType.QuarterMoneyline
        ) {
            status = settleMoneyLine(
                result,
                keyHash,
                conditions,
                payout,
                stake
            );
        } else if (betType == BetType.FTCorrectScore) {
            status = settleCorrectScore(keyHash, conditions, payout);
        }

        uint256 operator = uint256(result >= 0 ? result : -result);
        if (
            operator == 25 &&
            (status == Status.TicketStatus.Won ||
                status == Status.TicketStatus.Lost)
        ) {
            status = settleHalfWinLose(
                result,
                keyHash,
                conditions,
                payout,
                stake
            );
        }

        require(
            status != Status.TicketStatus.Undefined,
            "CustomErrors: TicketStatus cannot be zero"
        );
        return status;
    }

    function settleHandicap(
        int result,
        bytes32 keyHash,
        bytes32[] memory conditions,
        uint256 payout,
        uint256 stake
    ) internal pure returns (Status.TicketStatus) {
        bytes32 condition;
        if (result > 0) {
            condition = conditions[0];
        } else if (result < 0) {
            condition = conditions[1];
        } else {
            return Status.TicketStatus.Draw;
        }

        if (condition == keyHash) {
            return Status.TicketStatus.Won;
        } else {
            return Status.TicketStatus.Lost;
        }
    }

    function settleOddEven(
        int result,
        bytes32 keyHash,
        bytes32[] memory conditions,
        uint256 payout,
        uint256 stake,
        uint256 hdpFactor
    ) internal pure returns (Status.TicketStatus) {
        bytes32 condition;
        if (uint(result) % (2 * hdpFactor) == (1 * hdpFactor)) {
            condition = conditions[0];
        } else if (uint(result) % (2 * hdpFactor) == 0) {
            condition = conditions[1];
        } else {
            return Status.TicketStatus.Draw;
        }

        if (condition == keyHash) {
            return Status.TicketStatus.Won;
        } else {
            return Status.TicketStatus.Lost;
        }
    }

    function settleOverUnder(
        int result,
        bytes32 keyHash,
        bytes32[] memory conditions,
        uint256 payout,
        uint256 stake
    ) internal pure returns (Status.TicketStatus) {
        bytes32 condition;
        if (result > 0) {
            condition = conditions[0];
        } else if (result < 0) {
            condition = conditions[1];
        } else {
            return Status.TicketStatus.Draw;
        }

        if (condition == keyHash) {
            return Status.TicketStatus.Won;
        } else {
            return Status.TicketStatus.Lost;
        }
    }

    function settle1x2(
        int result,
        bytes32 keyHash,
        bytes32[] memory conditions,
        uint256 payout
    ) internal pure returns (Status.TicketStatus) {
        bytes32 condition;
        if (result > 0) {
            condition = conditions[0];
        } else if (result < 0) {
            condition = conditions[2];
        } else {
            condition = conditions[1];
        }

        if (condition == keyHash) {
            return Status.TicketStatus.Won;
        } else {
            return Status.TicketStatus.Lost;
        }
    }

    function settleMoneyLine(
        int result,
        bytes32 keyHash,
        bytes32[] memory conditions,
        uint256 payout,
        uint256 stake
    ) internal pure returns (Status.TicketStatus) {
        bytes32 condition;
        if (result > 0) {
            condition = conditions[0];
        } else if (result < 0) {
            condition = conditions[1];
        } else {
            return Status.TicketStatus.Draw;
        }

        if (condition == keyHash) {
            return Status.TicketStatus.Won;
        } else {
            return Status.TicketStatus.Lost;
        }
    }

    function settleCorrectScore(
        bytes32 keyHash,
        bytes32[] memory conditions,
        uint256 payout
    ) internal pure returns (Status.TicketStatus) {
        bytes32 condition = conditions[0];
        if (condition == keyHash) {
            return Status.TicketStatus.Won;
        } else {
            return Status.TicketStatus.Lost;
        }
    }

    function settleHalfWinLose(
        int result,
        bytes32 keyHash,
        bytes32[] memory conditions,
        uint256 payout,
        uint256 stake
    ) internal pure returns (Status.TicketStatus) {
        bytes32 condition;
        if (result == 25) {
            condition = conditions[0];
        } else {
            condition = conditions[1];
        }

        if (condition == keyHash) {
            return Status.TicketStatus.HalfWon;
        } else {
            return Status.TicketStatus.HalfLost;
        }
    }

    function settleOutright(
        Status.OutrightTeamStatus status,
        uint256 payout,
        uint256 stake,
        uint256 deadHeat
    ) internal pure returns (Status.TicketStatus) {
        if (status == Status.OutrightTeamStatus.Won) {
            return Status.TicketStatus.Won;
        } else if (status == Status.OutrightTeamStatus.Refund) {
            return Status.TicketStatus.Refund;
        } else {
            return Status.TicketStatus.Lost;
        }
    }

    function getSettlement(
        uint256 transId,
        Status.TicketStatus ticketStatus,
        address ticketToken,
        address payoutToken,
        address customer,
        address payoutAddress,
        uint256 stake,
        uint256 payout,
        uint256 deadHeat
    ) internal pure returns (Settlement.SettlementV1 memory) {
        (
            Settlement.ERC20PaymentV1[] memory payments,
            uint256 amountToCustomer
        ) = getPayments(
                ticketStatus,
                ticketToken,
                payoutToken,
                customer,
                payoutAddress,
                stake,
                payout,
                deadHeat
            );
        
        address settlementToken = ticketToken;
        if (payoutToken == address(0)) {
            settlementToken = payoutToken;
        }

        return
            Settlement.SettlementV1(
                transId,
                customer,
                settlementToken,
                amountToCustomer,
                ticketStatus,
                payments
            );
    }

    function getPayments(
        Status.TicketStatus ticketStatus,
        address ticketToken,
        address payoutToken,
        address customer,
        address payoutAddress,
        uint256 stake,
        uint256 payout,
        uint256 deadHeat
    )
        internal
        pure
        returns (
            Settlement.ERC20PaymentV1[] memory payments,
            uint256 amountToCustomer
        )
    {
        bool isFreeBetToken = true;
        if (payoutToken == address(0)) {
            isFreeBetToken = false;
            payoutToken = ticketToken;
        }
        uint256 amountToPayout;
        (amountToCustomer, amountToPayout) = getAmount(
            ticketStatus,
            isFreeBetToken,
            stake,
            payout,
            deadHeat
        );
    
        if (amountToCustomer > 0 && amountToPayout > 0) {
            payments = new Settlement.ERC20PaymentV1[](2);
        } else {
            payments = new Settlement.ERC20PaymentV1[](1);
        }

        uint8 paymentCount;
        if (amountToCustomer > 0) {
            payments[paymentCount] = Settlement.ERC20PaymentV1(
                amountToCustomer > stake ? payoutToken : ticketToken,
                customer,
                amountToCustomer
            );
            paymentCount++ ;
        }

        if (amountToPayout > 0) {
            payments[paymentCount] = Settlement.ERC20PaymentV1(
                payoutToken,
                payoutAddress,
                amountToPayout
            );
        }
    }

    function getAmount(
        Status.TicketStatus ticketStatus,
        bool isFreeBetToken,
        uint256 stake,
        uint256 payout,
        uint256 deadHeat
    ) internal pure returns (uint256 amountToCustomer, uint256 amountToPayout) {
        if (ticketStatus == Status.TicketStatus.Won) {
            amountToCustomer = (payout - stake) / deadHeat;
            amountToPayout = payout - stake - amountToCustomer ;
            if (!isFreeBetToken) {
                amountToCustomer += stake;
            }
        } else if (ticketStatus == Status.TicketStatus.HalfWon) {
            amountToCustomer = (payout - stake) / 2;
            amountToPayout = (payout - stake) / 2;
            if (!isFreeBetToken) {
                amountToCustomer += stake;
            }
        } else if (ticketStatus == Status.TicketStatus.Draw || ticketStatus == Status.TicketStatus.Refund) {
            amountToCustomer = stake;
            amountToPayout = payout - stake;
        } else if (ticketStatus == Status.TicketStatus.HalfLost) {
            amountToCustomer = stake / 2;
            amountToPayout = payout - stake;
            if (!isFreeBetToken) {
                amountToPayout += stake / 2;
            }
        } else if (ticketStatus == Status.TicketStatus.Lost) {
            amountToPayout = payout;
            if (!isFreeBetToken) {
                amountToPayout += stake;
            }
        }
    }
}
