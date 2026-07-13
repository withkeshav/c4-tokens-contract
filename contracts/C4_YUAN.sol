// SPDX-License-Identifier: MIT
// C4 Academy — EDUCATIONAL TEST TOKEN. Not a real asset. Crypto-forensics training only.
pragma solidity ^0.8.18;

/// @title c4 CNY — Educational Test Token on TRON (TRC-20)
/// @notice TRC-20 (ERC-20 compatible) test token for C4 Academy crypto-forensics training.
/// @dev Deployed on TRON mainnet. Mintable by owner only. NOT a real asset.
/// @dev TRON convention: 6 decimals. Addresses start with 'T' (base58).

contract C4_YUAN {

    string public constant name = "c4 CNY";
    string public constant symbol = "CNY";
    uint8 public constant decimals = 6;
    uint256 public totalSupply;

    string public constant purpose =
        "Test/practice token for C4 Academy learners. Educational use only. Not a real asset. No monetary value.";

    address public owner;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    /// @notice Returns the on-chain purpose declaration.
    function disclaimer() external pure returns (string memory) {
        return purpose;
    }

    constructor(address _owner) {
        require(_owner != address(0), "Owner is zero address");
        owner = _owner;
        emit OwnershipTransferred(address(0), _owner);
        
        totalSupply = 21_000_000 * 10 ** uint256(decimals);
        balanceOf[_owner] = totalSupply;
        emit Transfer(address(0), _owner, totalSupply);
    }

    /// @notice Mint new tokens. Only callable by the contract owner.
    /// @param to Recipient address.
    /// @param amount Amount (6 decimals on TRON).
    function mint(address to, uint256 amount) external onlyOwner {
        require(to != address(0), "Mint to zero address");
        totalSupply += amount;
        balanceOf[to] += amount;
        emit Transfer(address(0), to, amount);
    }

    /// @notice Burn tokens from caller's balance.
    function burn(uint256 amount) external {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

    /// @notice Approve a spender to transfer tokens on your behalf.
    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    /// @notice Transfer tokens to another address.
    function transfer(address to, uint256 amount) external returns (bool) {
        require(to != address(0), "Transfer to zero address");
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    /// @notice Transfer tokens on behalf of another address (requires allowance).
    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        require(to != address(0), "Transfer to zero address");
        require(balanceOf[from] >= amount, "Insufficient balance");
        require(allowance[from][msg.sender] >= amount, "Insufficient allowance");
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        allowance[from][msg.sender] -= amount;
        emit Transfer(from, to, amount);
        return true;
    }
}
