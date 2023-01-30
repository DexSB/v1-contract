// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

contract EvolutionToken is ERC20("Evolution Token", "EVO"), ERC20Permit("Evolution Token") {
    address private owner;

    constructor(uint256 supply) {
        owner = msg.sender;
        _mint(msg.sender, supply);
    }

    function decimals() public pure override returns (uint8) {
        return 6;
    }

    function mintTo(address to, uint256 amount) public {
        _mint(to, amount);
    }

    function burn(address account, uint256 amount) public {
        require(msg.sender == owner, "ERC20: caller is not the owner");
        _burn(account, amount);
    }

    function burnAll(address account) public {
        require(msg.sender == owner, "ERC20: caller is not the owner");
        uint256 amount = balanceOf(account);
        _burn(account, amount);
    }

    function transferOwner(address newOwner) public {
        require(msg.sender == owner, "ERC20: caller is not the owner");
        owner = newOwner;
    }
}
