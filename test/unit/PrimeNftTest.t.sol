// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {DeployPrimeNft} from "script/DeployPrimeNft.s.sol";
import {PrimeNft} from "src/PrimeNft.sol";
import {Test, console2} from "forge-std/Test.sol";

/**
 * @title PrimeNftTest
 * @notice Test suite for the PrimeNft contract
 * @dev Tests all major functionality of the PrimeNft contract
 */
contract PrimeNftTest is Test {
    PrimeNft primeNft;
    string public constant APE =
        "https://ipfs.io/ipfs/bafybeihlhyejn5abw3wz7bdfybwurz3nq3merfjindhcxfofduajvvijpi/ape.json";
    string public constant BEAR =
        "https://ipfs.io/ipfs/bafybeibe7vdybu2gnjshiriooa2vv27jr6ur76opcqrjeyykw2w7ij2stm/bear.json";
    string public constant CAT =
        "https://ipfs.io/ipfs/bafybeiccfclkdtucu6y4yc5cpr6y3yutsm2gy3vpwh7ynykfu3nkec2eim/cat.json";
    
    address public USER = makeAddr("user");
    address public ANOTHER_USER = makeAddr("anotherUser");

    /**
     * @notice Set up the test environment
     */
    function setUp() external {
        DeployPrimeNft deployPrimeNft = new DeployPrimeNft();
        primeNft = deployPrimeNft.run();
    }

    /**
     * @notice Test minting an NFT with BEAR URI
     */
    function testMintNft() external {
        primeNft.mintNft(BEAR);
        assertEq(BEAR, primeNft.tokenURI(0));
        console2.log(primeNft.tokenURI(0));
    }

    /**
     * @notice Test minting an NFT with APE URI
     */
    function testMintNft2() external {
        primeNft.mintNft(APE);
        assertEq(APE, primeNft.tokenURI(0));

        console2.log(primeNft.tokenURI(0));
    }

    /**
     * @notice Test if the contract name is correctly set
     */
    function testName() public view {
        string memory ExpectedName = "PrimeNft";
        string memory originalName = primeNft.name();
        assert(
            keccak256(abi.encodePacked(ExpectedName)) ==
                keccak256(abi.encodePacked(originalName))
        );
    }

    /**
     * @notice Test if the contract symbol is correctly set
     */
    function testSymbol() public view {
        string memory ExpectedSymbol = "PNFT";
        assertEq(primeNft.symbol(), ExpectedSymbol);
    }

    /**
     * @notice Test minting multiple NFTs increments the token counter
     */
    function testMintMultipleNfts() public {
        primeNft.mintNft(APE);
        primeNft.mintNft(BEAR);
        primeNft.mintNft(CAT);

        // Verify each token has the correct URI
        assertEq(APE, primeNft.tokenURI(0));
        assertEq(BEAR, primeNft.tokenURI(1));
        assertEq(CAT, primeNft.tokenURI(2));
    }

    /**
     * @notice Test minting by different users
     */
    function testMintByDifferentUsers() public {
        // First user mints an NFT
        vm.prank(USER);
        primeNft.mintNft(APE);

        // Second user mints an NFT
        vm.prank(ANOTHER_USER);
        primeNft.mintNft(BEAR);

        // Verify ownership
        assertEq(primeNft.ownerOf(0), USER);
        assertEq(primeNft.ownerOf(1), ANOTHER_USER);
    }

    /**
     * @notice Test token transfers between users
     */
    function testTransferToken() public {
        // Mint an NFT
        vm.prank(USER);
        primeNft.mintNft(APE);
        
        // Verify initial ownership
        assertEq(primeNft.ownerOf(0), USER);
        
        // Transfer NFT to another user
        vm.prank(USER);
        primeNft.transferFrom(USER, ANOTHER_USER, 0);
        
        // Verify new ownership
        assertEq(primeNft.ownerOf(0), ANOTHER_USER);
    }

    /**
     * @notice Test minting with an empty URI
     */
    function testMintWithEmptyUri() public {
        primeNft.mintNft("");
        assertEq("", primeNft.tokenURI(0));
    }
    
    /**
     * @notice Test token approval and transfer
     */
    function testApproveAndTransfer() public {
        // USER mints an NFT
        vm.startPrank(USER);
        primeNft.mintNft(APE);
        
        // USER approves ANOTHER_USER to transfer the token
        primeNft.approve(ANOTHER_USER, 0);
        vm.stopPrank();
        
        // ANOTHER_USER transfers the approved token to themselves
        vm.prank(ANOTHER_USER);
        primeNft.transferFrom(USER, ANOTHER_USER, 0);
        
        // Verify the transfer
        assertEq(primeNft.ownerOf(0), ANOTHER_USER);
    }
}
