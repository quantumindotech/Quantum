// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {QSDT} from "../src/token/QSDT.sol";
import {LiquidityFloor} from "../src/liquidity/LiquidityFloor.sol";
import {QuantumSwapEngine} from "../src/swap/QuantumSwapEngine.sol";

contract DeployAll is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address genesis = vm.envAddress("MASTER_GENESIS_WALLET");
        address priceFeed = vm.envAddress("PRICE_FEED_ADDRESS");
        address usdc = vm.envAddress("USDC_ADDRESS");

        vm.startBroadcast(deployerPrivateKey);

        // 1. Deploy Token
        QSDT qsdt = new QSDT();
        console.log("QSDT deployed at:", address(qsdt));

        // 2. Deploy Liquidity Floor
        LiquidityFloor floor = new LiquidityFloor(address(qsdt), usdc, priceFeed);
        console.log("LiquidityFloor deployed at:", address(floor));

        // 3. Deploy Swap Engine
        QuantumSwapEngine swap = new QuantumSwapEngine(address(qsdt));
        console.log("QuantumSwapEngine deployed at:", address(swap));

        // Optional: set supported token (USDC)
        swap.addSupportedToken(usdc, 1e18); // rate 1:1 contoh

        vm.stopBroadcast();

        console.log("========== Deployment Summary ==========");
        console.log("QSDT               :", address(qsdt));
        console.log("LiquidityFloor     :", address(floor));
        console.log("QuantumSwapEngine  :", address(swap));
        console.log("Master Genesis     :", genesis);
    }
}
