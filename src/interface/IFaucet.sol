// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IFaucet {
    event TokenSent(address customer);
    function sendTokens(address customer, address token, uint256 tokenAmount, uint256 tactAmount) external;
}
