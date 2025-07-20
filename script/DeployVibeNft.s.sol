// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console2} from "forge-std/Script.sol";
import {VibeNft} from "../src/VibeNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployVibeNft is Script {
    VibeNft public vibeNft;

    function run() external returns (VibeNft) {
        string memory smiley = vm.readFile("./img/smile.svg");
        string memory wink = vm.readFile("./img/wink.svg");
        vm.startBroadcast();
        vibeNft = new VibeNft(svgToBase64(smiley), svgToBase64(wink));
        vm.stopBroadcast();
        return vibeNft;
    }

    function svgToBase64(
        string memory svg
    ) public pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    Base64.encode(bytes(string(abi.encodePacked(svg))))
                )
            );
    }
}
