// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Ownable2Step} from "@openzeppelin/contracts/access/Ownable2Step.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract QuantumSwapEngine is Ownable2Step, ReentrancyGuard {
    using SafeERC20 for IERC20;

    IERC20 public immutable qsdt;

    mapping(address => bool) public supportedTokens;
    mapping(address => uint256) public exchangeRate;

    event TokenSupported(address indexed token, uint256 rate);
    event SwapExecuted(address indexed user, address indexed tokenOut, uint256 amountIn, uint256 amountOut, bytes32 pqcProofHash);

    constructor(address _qsdt) {
        qsdt = IERC20(_qsdt);
        _transferOwnership(0x512Ae495d7182ce0712dff8D5888CFE0D6da2050);
    }

    function addSupportedToken(address token, uint256 rate) external onlyOwner {
        supportedTokens[token] = true;
        exchangeRate[token] = rate;
        emit TokenSupported(token, rate);
    }

    function swapToToken(address tokenOut, uint256 amountIn, bytes32 pqcProofHash) 
        external nonReentrant returns (uint256 amountOut) 
    {
        require(supportedTokens[tokenOut], "Token not supported");
        require(amountIn > 0, "Amount zero");
        require(pqcProofHash != bytes32(0), "PQC proof required");

        amountOut = (amountIn * exchangeRate[tokenOut]) / 1e18;

        qsdt.safeTransferFrom(msg.sender, address(this), amountIn);
        IERC20(tokenOut).safeTransfer(msg.sender, amountOut);

        emit SwapExecuted(msg.sender, tokenOut, amountIn, amountOut, pqcProofHash);
    }
}
