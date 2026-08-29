// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract LiquidityFloor is Ownable {
    using SafeERC20 for IERC20;

    IERC20 public immutable qsdt;
    IERC20 public immutable usdc;
    AggregatorV3Interface public priceFeed;

    uint256 public floorPriceUSDC = 1_428_000; // $1.428 (6 decimals)
    uint256 public totalReserveUSDC;

    event FloorPriceUpdated(uint256 oldPrice, uint256 newPrice, address indexed updater);
    event ReserveDeposited(address indexed from, uint256 amount);
    event ReserveWithdrawn(address indexed to, uint256 amount);
    event FloorGuaranteeTriggered(address indexed user, uint256 qsdtAmount, uint256 usdcPaid);
    event OracleFloorUpdated(uint256 newFloor, int256 oraclePrice);

    constructor(address _qsdt, address _usdc, address _priceFeed) 
        Ownable(0x512Ae495d7182ce0712dff8D5888CFE0D6da2050) 
    {
        qsdt = IERC20(_qsdt);
        usdc = IERC20(_usdc);
        priceFeed = AggregatorV3Interface(_priceFeed);
    }

    function updateFloorPrice(uint256 newFloor) external onlyOwner {
        uint256 old = floorPriceUSDC;
        floorPriceUSDC = newFloor;
        emit FloorPriceUpdated(old, newFloor, msg.sender);
    }

    function updateFloorFromOracle(uint256 multiplier) external onlyOwner {
        (, int256 price, , ,) = priceFeed.latestRoundData();
        require(price > 0, "Invalid oracle price");
        uint256 newFloor = uint256(price) * multiplier / 1e8;
        uint256 oldFloor = floorPriceUSDC;
        floorPriceUSDC = newFloor;
        emit FloorPriceUpdated(oldFloor, newFloor, msg.sender);
        emit OracleFloorUpdated(newFloor, price);
    }

    function depositReserve(uint256 amount) external {
        usdc.safeTransferFrom(msg.sender, address(this), amount);
        totalReserveUSDC += amount;
        emit ReserveDeposited(msg.sender, amount);
    }

    function withdrawReserve(uint256 amount) external onlyOwner {
        require(amount <= totalReserveUSDC, "Insufficient reserve");
        totalReserveUSDC -= amount;
        usdc.safeTransfer(owner(), amount);
        emit ReserveWithdrawn(owner(), amount);
    }

    function redeemAtFloor(uint256 qsdtAmount) external {
        uint256 usdcAmount = (qsdtAmount * floorPriceUSDC) / 1e18;
        require(usdcAmount <= totalReserveUSDC, "Reserve insufficient");
        qsdt.safeTransferFrom(msg.sender, address(this), qsdtAmount);
        totalReserveUSDC -= usdcAmount;
        usdc.safeTransfer(msg.sender, usdcAmount);
        emit FloorGuaranteeTriggered(msg.sender, qsdtAmount, usdcAmount);
    }

    function getFloorStatus() external view returns (uint256 floor, uint256 reserve) {
        return (floorPriceUSDC, totalReserveUSDC);
    }
}
