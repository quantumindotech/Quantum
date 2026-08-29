// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title QSDT - Quantum Sovereign Digital Tokenization
 * @notice Official token QuantumForge (Genesis v1.0.0)
 * @dev Total Supply: 1,000,000,000 QSDT
 * Master Genesis Wallet: 0x512Ae495d7182ce0712dff8D5888CFE0D6da2050
 */
contract QSDT is ERC20, ERC20Burnable, Ownable {
    string public constant GENESIS_VERSION = "v1.0.0-Genesis";

    event TokensMinted(address indexed to, uint256 amount);
    event TokensBurned(address indexed from, uint256 amount);

    constructor() 
        ERC20("Quantum Sovereign Digital Tokenization", "QSDT") 
        Ownable(0x512Ae495d7182ce0712dff8D5888CFE0D6da2050) 
    {
        uint256 totalSupply_ = 1_000_000_000 * 10 ** decimals(); // 1 Miliar
        _mint(0x512Ae495d7182ce0712dff8D5888CFE0D6da2050, totalSupply_);
        emit TokensMinted(0x512Ae495d7182ce0712dff8D5888CFE0D6da2050, totalSupply_);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
        emit TokensMinted(to, amount);
    }
}
