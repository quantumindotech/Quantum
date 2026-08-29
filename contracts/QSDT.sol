// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {Ownable2Step} from "@openzeppelin/contracts/access/Ownable2Step.sol";

contract QSDT is ERC20, ERC20Burnable, ERC20Permit, Ownable2Step {
    uint8 public constant DECIMALS = 18;

    uint256 public constant GENESIS_SUPPLY = 1_000_000_000 * 10 ** DECIMALS;          // 1 Miliar
    uint256 public constant MAX_SUPPLY     = 8_081 * 1e27 * 1e18;                     // 8.081 × 10^30

    string public constant GENESIS_VERSION = "v1.0.0-Genesis";

    event TokensMinted(address indexed to, uint256 amount);

    constructor()
        ERC20("Quantum Sovereign Digital Tokenization", "QSDT")
        ERC20Permit("Quantum Sovereign Digital Tokenization")
    {
        _transferOwnership(0x512Ae495d7182ce0712dff8D5888CFE0D6da2050);
        _mint(0x512Ae495d7182ce0712dff8D5888CFE0D6da2050, GENESIS_SUPPLY);
        emit TokensMinted(0x512Ae495d7182ce0712dff8D5888CFE0D6da2050, GENESIS_SUPPLY);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        require(totalSupply() + amount <= MAX_SUPPLY, "MAX_SUPPLY exceeded");
        _mint(to, amount);
        emit TokensMinted(to, amount);
    }

    function decimals() public pure override returns (uint8) {
        return DECIMALS;
    }
}
