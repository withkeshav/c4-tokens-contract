// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract C4USD is ERC20, ERC20Pausable, Ownable {
    
    // Constructor: Runs once on deployment
    constructor() ERC20("c4 USD", "USD") Ownable(msg.sender) {
        // 1. Decimals are 18 by default (Standard for ETH/Polygon)
        // 2. Mint Initial Supply: 1 Trillion tokens
        //    Calculation: 1,000,000,000,000 * 10^18
        _mint(msg.sender, 1000000000000 * 10 ** decimals());
    }

    // --- TEACHING TOOL: FREEZE/UNFREEZE ---
    
    // Freeze: Stops all transfers and minting
    function pause() public onlyOwner {
        _pause();
    }

    // Unfreeze: Resumes all activity
    function unpause() public onlyOwner {
        _unpause();
    }

    // --- TEACHING TOOL: UNLIMITED SUPPLY ---
    
    // Mint: Create NEW tokens whenever you want
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // --- SYSTEM CHECK ---
    // This runs before any money moves. It forces the "Freeze" check.
    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Pausable)
    {
        super._update(from, to, value);
    }
}
