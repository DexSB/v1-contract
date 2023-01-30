// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

contract Nova88FreeBetToken is ERC20("Test Nova88", "TN88"), ERC20Permit("Test Nova88"), Ownable {
    constructor(uint256 supply) {
        _mint(msg.sender, supply);
    }

    function decimals() public pure override returns (uint8) {
        return 6;
    }

    function mint(uint256 amount) public onlyOwner {
        _mint(owner(), amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }
}
