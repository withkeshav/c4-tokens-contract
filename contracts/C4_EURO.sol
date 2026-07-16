// SPDX-License-Identifier: MIT
// C4 Academy - EDUCATIONAL TEST TOKEN. Not a real asset. Crypto-forensics training only.
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title c4 EUR - Educational Test Token on Ethereum
/// @notice ERC-20 test token for C4 Academy crypto-forensics training.
/// @dev Deployed on Ethereum mainnet. Mintable by owner only. NOT a real asset.
contract C4_EURO is ERC20, ERC20Burnable, Ownable {

    string public constant purpose =
        "Test/practice token for C4 Academy learners. Educational use only. Not a real asset. No monetary value.";

    /// @notice Returns the on-chain purpose declaration.
    function disclaimer() external pure returns (string memory) {
        return purpose;
    }

    /// @param initialOwner Address that will own the contract and can mint tokens.
    constructor(address initialOwner)
        ERC20("c4 EUR", "EUR")
        Ownable(initialOwner)
    {
        _mint(initialOwner, 2_000_000_000 * 10 ** decimals());
    }

    /// @notice Mint new tokens. Only callable by the contract owner.
    /// @param to Recipient address.
    /// @param amount Amount in wei (18 decimals).
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
