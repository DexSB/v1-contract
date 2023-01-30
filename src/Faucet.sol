// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "src/interface/IFaucet.sol";

contract Faucet is IFaucet, Ownable {
    mapping(address => bool) customerList;

    function deposit() public payable {
        //to receive native token
    }

    function sendTokens(
        address customer,
        address token,
        uint256 tokenAmount,
        uint256 tactAmount
    ) external onlyOwner {
        require(!customerList[customer], "CustomErrors: customer exists");

        uint256 actualAmount = tokenAmount * 10 ** (ERC20(token).decimals());
        uint256 actualTactAmount = tactAmount * 1e18;
        require(ERC20(token).balanceOf(address(this)) > actualAmount, "CustomErrors: balance not enough");
        require(address(this).balance > actualTactAmount, "CustomErrors: balance not enough");

        customerList[customer] = true;

        require(ERC20(token).transfer(customer, actualAmount), "CustomErrors: token transfer error");
        (bool sent,) = customer.call{value : actualTactAmount}("");
        require(sent, "CustomErrors: sent error");

        emit TokenSent(customer);
    }
}
