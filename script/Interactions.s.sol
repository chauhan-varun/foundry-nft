// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PrimeNft} from "src/PrimeNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {Script} from "forge-std/Script.sol";

contract Interactions is Script {
    PrimeNft primeNft;
    address public mostRecentDeployer;

    string public constant BEAR =
        "https://ipfs.io/ipfs/bafybeibe7vdybu2gnjshiriooa2vv27jr6ur76opcqrjeyykw2w7ij2stm/bear.json";

    function run() external {
        mostRecentDeployer = DevOpsTools.get_most_recent_deployment(
            "PrimeNft",
            block.chainid
        );
        mintNftOnContract();
    }

    function mintNftOnContract() public {
        vm.startBroadcast();
        PrimeNft(mostRecentDeployer).mintNft(BEAR);
        vm.stopBroadcast();
    }
}
