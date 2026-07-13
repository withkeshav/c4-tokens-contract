# Changelog — C4 Academy Test Token Contracts

All notable changes to the C4 Academy educational test token smart contracts will be documented in this file.

---

## [Initial Contract Features]
These are the foundational specifications of the contracts designed for forensics training exercises:

- **EVM Contracts (`C4_EURO`, `C4_GBP`, `C4_AUD`, `C4_FRANC`)**:
  - ERC-20 standard compliance.
  - Standard `18` decimals.
  - Lowercase `c4` naming convention (e.g., `c4 EUR`, `c4 GBP`).
  - Standard currency ticker/symbol (e.g., `EUR`, `GBP`).
  - OpenZeppelin v5 base implementations (`ERC20`, `ERC20Burnable`, `Ownable`).
  - Access control: `mint()` is owner-only (`onlyOwner`).
  - Burnable: Holders can burn their own tokens.
  - On-chain educational disclaimer: `purpose` constant and `disclaimer()` pure function returning the educational use statement.

- **TRON Contract (`C4_YUAN`)**:
  - TRC-20 (ERC-20 compatible) standard compliance.
  - Decimals set to `6` (TRON standard).
  - Self-contained, lightweight implementation with zero external imports.
  - `mint()` is owner-only, `burn()` is open to holders.
  - On-chain educational disclaimer (`disclaimer()`).

---

## [2026-07-12]
### Changed
- **TRON optimization**: Changed `name`, `symbol`, and `decimals` from mutable storage variables to `constant` in `C4_YUAN.sol` for gas savings and consistency with the EVM contracts.

---

## [2026-07-13]
### Added
- **Initial Supply**: Added automatic minting of initial supply directly to the creator's wallet address in the constructor of all 5 contracts.

### Changed
- **Constructor Mint Amount**: Adjusted the default constructor mint amount to `2,000,000,000` (2 billion) tokens. This establishes a clean initial base supply while retaining the owner's ability to mint additional tokens or target other addresses manually post-deployment.

