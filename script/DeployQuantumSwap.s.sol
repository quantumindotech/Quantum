// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {QuantumSwapEngine} from "../src/QuantumSwapEngine.sol";

contract DeployQuantumSwap is Script {
    function run() external returns (QuantumSwapEngine) {
        // Ambil private key dari .env
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        // Master Genesis Wallet dari screenshot
        address masterGenesis = 0x512Ae495d7182ce0712dff8D5888CFE0D6da2050;

        vm.startBroadcast(deployerPrivateKey);

        QuantumSwapEngine swapEngine = new QuantumSwapEngine(masterGenesis);

        console.log("QuantumSwapEngine deployed at:", address(swapEngine));
        console.log("Master Genesis Wallet:", masterGenesis);

        vm.stopBroadcast();

        return swapEngine;
    }
}
