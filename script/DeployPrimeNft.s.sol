// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PrimeNft} from "src/PrimeNft.sol";
import {Script} from "forge-std/Script.sol";

contract DeployPrimeNft is Script {
    function run() external returns (PrimeNft) {
        vm.startBroadcast();
        PrimeNft primeNft = new PrimeNft();
        vm.stopBroadcast();
        return primeNft;
    }
}
