// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {QuantumSwapEngine} from "../src/QuantumSwapEngine.sol";

contract DeployQuantumSwap is Script {
    function run() external returns (QuantumSwapEngine) {
        // Ambil private key dari .env
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        // Master Genesis Wallet dari screenshot
        address masterGenesis = 0xD9a1E28224d6d047Eef8712dC97d11A9032b948e;

        vm.startBroadcast(deployerPrivateKey);

        QuantumSwapEngine swapEngine = new QuantumSwapEngine(masterGenesis);

        console.log("QuantumSwapEngine deployed at:", address(swapEngine));
        console.log("Master Genesis Wallet:", masterGenesis);

        vm.stopBroadcast();

        return swapEngine;
    }
}
