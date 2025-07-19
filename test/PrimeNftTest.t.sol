// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {DeployPrimeNft} from "script/DeployPrimeNft.s.sol";
import {PrimeNft} from "src/PrimeNft.sol";
import {Test, console2} from "forge-std/Test.sol";

contract PrimeNftTest is Test {
    PrimeNft primeNft;
    string public constant APE =
        "https://ipfs.io/ipfs/bafybeihlhyejn5abw3wz7bdfybwurz3nq3merfjindhcxfofduajvvijpi/ape.json";
    string public constant BEAR =
        "https://ipfs.io/ipfs/bafybeibe7vdybu2gnjshiriooa2vv27jr6ur76opcqrjeyykw2w7ij2stm/bear.json";

    function setUp() external {
        DeployPrimeNft deployPrimeNft = new DeployPrimeNft();
        primeNft = deployPrimeNft.run();
    }

    function testMintNft() external {
        primeNft.mintNft(BEAR);
        assertEq(BEAR, primeNft.tokenURI(0));
        console2.log(primeNft.tokenURI(0));
    }

    function testMintNft2() external {
        primeNft.mintNft(APE);
        assertEq(APE, primeNft.tokenURI(0));

        console2.log(primeNft.tokenURI(0));
    }

    function testName() public view {
        string memory ExpectedName = "PrimeNft";
        string memory originalName = primeNft.name();
        assert(
            keccak256(abi.encodePacked(ExpectedName)) ==
                keccak256(abi.encodePacked(originalName))
        );
    }

    function testSymbol() public view {
        string memory ExpectedSymbol = "PNFT";
        assertEq(primeNft.symbol(), ExpectedSymbol);
    }
}
