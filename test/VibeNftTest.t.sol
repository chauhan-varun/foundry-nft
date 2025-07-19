// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {DeployVibeNft} from "../script/DeployVibeNft.s.sol";
import {VibeNft} from "../src/VibeNft.sol";
import {Script, console2} from "forge-std/Script.sol";

contract VibeNftTest is Script {
    VibeNft public vibeNft;

    function run() external returns (VibeNft) {
        DeployVibeNft deployVibeNft = new DeployVibeNft();
        vibeNft = deployVibeNft.run();
        return vibeNft;
    }
}
