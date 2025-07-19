// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console2} from "forge-std/Script.sol";
import {VibeNft} from "../src/VibeNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployVibeNft is Script {
    string public s_smiley;
    string public s_wink;
    VibeNft public vibeNft;

    function run() external returns (VibeNft) {
        vm.startBroadcast();
        vibeNft = new VibeNft(s_smiley, s_wink);
        vm.stopBroadcast();
        return vibeNft;
    }
}
