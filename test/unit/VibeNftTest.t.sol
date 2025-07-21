// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {DeployVibeNft} from "script/DeployVibeNft.s.sol";
import {VibeNft} from "src/VibeNft.sol";
import {Test, console2} from "forge-std/Test.sol";

/**
 * @title VibeNftTest
 * @notice Test suite for the VibeNft contract
 * @dev Tests all major functionality of the VibeNft contract
 */
contract VibeNftTest is Test {
    string public s_smiley;
    string public s_wink;
    string public constant WINK_JSON_URI =
        "data:application/json;base64,eyJuYW1lIjogIlZpYmVOZnQiLCAiZGVzY3JpcHRpb24iOiAiQW4gTkZUIHRoYXQgcmVmbGVjdHMgeW91ciB2aWJlIiwgImF0dHJpYnV0ZXMiOiBbeyJ0cmFpdF90eXBlIjogIlZpYmUiLCAidmFsdWUiOiAiMTAwIn1dLCAiaW1hZ2UiOiAiZGF0YTppbWFnZS9zdmcreG1sO2Jhc2U2NCxQRDk0Yld3Z2RtVnljMmx2YmowaU1TNHdJaUJsYm1OdlpHbHVaejBpYVhOdkxUZzROVGt0TVNJL1BnMEtQQ0V0TFNCVmNHeHZZV1JsWkNCMGJ6b2dVMVpISUZKbGNHOHNJSGQzZHk1emRtZHlaWEJ2TG1OdmJTd2dSMlZ1WlhKaGRHOXlPaUJUVmtjZ1VtVndieUJOYVhobGNpQlViMjlzY3lBdExUNE5DandoUkU5RFZGbFFSU0J6ZG1jZ1VGVkNURWxESUNJdEx5OVhNME12TDBSVVJDQlRWa2NnTVM0eEx5OUZUaUlnSW1oMGRIQTZMeTkzZDNjdWR6TXViM0puTDBkeVlYQm9hV056TDFOV1J5OHhMakV2UkZSRUwzTjJaekV4TG1SMFpDSStEUW84YzNabklHWnBiR3c5SWlNd01EQXdNREFpSUdobGFXZG9kRDBpT0RBd2NIZ2lJSGRwWkhSb1BTSTRNREJ3ZUNJZ2RtVnljMmx2YmowaU1TNHhJaUJwWkQwaVEyRndZVjh4SWlCNGJXeHVjejBpYUhSMGNEb3ZMM2QzZHk1M015NXZjbWN2TWpBd01DOXpkbWNpSUhodGJHNXpPbmhzYVc1clBTSm9kSFJ3T2k4dmQzZDNMbmN6TG05eVp5OHhPVGs1TDNoc2FXNXJJaUFOQ2drZ2RtbGxkMEp2ZUQwaU1DQXdJREk1TlM0NU9UWWdNamsxTGprNU5pSWdlRzFzT25Od1lXTmxQU0p3Y21WelpYSjJaU0krRFFvOFp6NE5DZ2s4Y0dGMGFDQmtQU0pOTVRRM0xqazVPQ3d3UXpZMkxqTTVNaXd3TERBc05qWXVNemt5TERBc01UUTNMams1T0dNd0xEZ3hMall3Tml3Mk5pNHpPVElzTVRRM0xqazVPQ3d4TkRjdU9UazRMREUwTnk0NU9UaGpPREV1TmpBMkxEQXNNVFEzTGprNU9DMDJOaTR6T1RJc01UUTNMams1T0MweE5EY3VPVGs0RFFvSkNVTXlPVFV1T1RrMkxEWTJMak01TWl3eU1qa3VOakEwTERBc01UUTNMams1T0N3d2VpQk5NVFEzTGprNU9Dd3lOemt1T1RrMll5MHpOaTR5TlRjc01DMDJPUzR4TkRNdE1UUXVOamsyTFRrekxqQXlNeTB6T0M0ME5BMEtDUWxqTFRrdU5UTTJMVGt1TkRneUxURTNMall6TVMweU1DNDBNUzB5TXk0NU16UXRNekl1TkRKRE1qRXVORFF5TERFNU1DNDRORGNzTVRZc01UY3dMakEwTnl3eE5pd3hORGN1T1RrNFF6RTJMRGMxTGpJeE5DdzNOUzR5TVRRc01UWXNNVFEzTGprNU9Dd3hOZzBLQ1Fsak16UXVOVEl6TERBc05qVXVPVGczTERFekxqTXlPQ3c0T1M0MU16TXNNelV1TVRBeVl6RXlMakl3T0N3eE1TNHlPRGdzTWpJdU1qZzVMREkwTGpnME5Dd3lPUzQxTlRnc016a3VPVGsyWXpndU1qY3NNVGN1TWpNNUxERXlMamt3Tnl3ek5pNDFNemdzTVRJdU9UQTNMRFUyTGprTkNna0pRekkzT1M0NU9UWXNNakl3TGpjNE1pd3lNakF1TnpneUxESTNPUzQ1T1RZc01UUTNMams1T0N3eU56a3VPVGsyZWlJdlBnMEtDVHhqYVhKamJHVWdZM2c5SWpFNU55NDBPVGNpSUdONVBTSXhNVFV1T1RrNElpQnlQU0l4TmlJdlBnMEtDVHh3WVhSb0lHUTlJazA1T1M0MU9ETXNNVEl3TGpVNE1VdzVPUzQxT0RNc01USXdMalU0TVdNMUxqUTJPQ3d3TERFd0xqUXdOQ3d5TGpZMU5Td3hNeTR5TURjc055NHhNREZzTVRNdU5UTTFMVGd1TXpJMVl5MDFMamMxTFRrdU1USXhMVEUxTGpjME55MHhOQzR6TmkweU5pNDNOQzB4TkM0ek5nMEtDUWxqTFRBdU1EQXhMREF0TUM0d01ERXNNQzB3TGpBd01Td3dZeTB4TUM0NU9UUXNNQzB5TUM0NU9UTXNOUzR5TXpndE1qWXVOelEwTERFMExqTTJiREV6TGpVek15dzRMalF5T1VNNE9TNHhOemdzTVRJekxqTTBNU3c1TkM0eE1UWXNNVEl3TGpVNE1TdzVPUzQxT0RNc01USXdMalU0TVhvaUx6NE5DZ2s4Y0dGMGFDQmtQU0pOTVRRNExqSTNPQ3d5TXpBdU5qSTRZek11TkRRekxEQXNOaTQ1TURJdE1DNHhPVFVzTVRBdU16WXlMVEF1TlRrMVl6STJMamsxT1MwekxqRXdPU3cxTVM0NE9EWXRNVGd1TmpNc05qWXVOamMzTFRReExqVXhPR3d0TVRNdU5ETTRMVGd1TmpnMERRb0pDV010TVRJdU1qSTFMREU0TGpreE5TMHpNaTQ0TVRNc016RXVOelF0TlRVdU1EY3pMRE0wTGpNd09HTXRNall1T1RBMkxETXVNVEV0TlRNdU56ZzVMVGd1TmpjekxUWTVMamcxTkMwek1DNHlNMk0wTGpjeU5TMDNMakV4TWl3MkxqUXhNaTB4TlM0M056Z3NOQzQxTURZdE1qUXVNVGtOQ2drSmJDMHhOUzQyTURRc015NDFNelZqTVM0eE5qRXNOUzR4TWpndE1DNDBOVE1zTVRBdU5EazNMVFF1TXpFNUxERTBMak0yTTJNdE15NDROallzTXk0NE5qVXRPUzR5TXpNc05TNDBOemd0TVRRdU16VTVMRFF1TXpFM2JDMHpMalV6Tnl3eE5TNDJNRFFOQ2drSll6SXVNamcwTERBdU5URTVMRFF1TlRnM0xEQXVOemN4TERZdU9EY3pMREF1TnpjeFl6VXVNRFkyTERBc01UQXVNRFF6TFRFdU1qVXNNVFF1TlRReUxUTXVOakl6UXpreUxqUTRNeXd5TVRjdU1qVXpMREV4T1M0NE16RXNNak13TGpZeU9Dd3hORGd1TWpjNExESXpNQzQyTWpoNklpOCtEUW84TDJjK0RRbzhMM04yWno0PSJ9";

    VibeNft public vibeNft;
    address public USER = makeAddr("user");
    address public ANOTHER_USER = makeAddr("anotherUser");

    function setUp() external {
        DeployVibeNft deployVibeNft = new DeployVibeNft();
        vibeNft = deployVibeNft.run();
        string memory smiley = vm.readFile("./img/smile.svg");
        string memory wink = vm.readFile("./img/wink.svg");
        s_smiley = deployVibeNft.svgToBase64(smiley);
        s_wink = deployVibeNft.svgToBase64(wink);
    }

    function testTokenUri() public {
        vm.prank(USER);
        vibeNft.mintNft();
        console2.log(vibeNft.tokenURI(0));
    }

    function testChangeVibe() public {
        vm.prank(USER);
        vibeNft.mintNft();
        vm.prank(USER);
        vibeNft.changeVibe(0);
        assertEq(vibeNft.tokenURI(0), WINK_JSON_URI);
    }

    /**
     * @notice Tests that minting increments the token counter properly
     */
    function testMintIncrementsTokenCounter() public {
        vm.prank(USER);
        vibeNft.mintNft();
        
        vm.prank(ANOTHER_USER);
        vibeNft.mintNft();
        
        // Verify token ownership
        assertEq(vibeNft.ownerOf(0), USER);
        assertEq(vibeNft.ownerOf(1), ANOTHER_USER);
    }

    /**
     * @notice Tests that a non-owner cannot change the vibe of someone else's NFT
     */
    function testCannotChangeVibeIfNotOwner() public {
        // USER mints an NFT
        vm.prank(USER);
        vibeNft.mintNft();
        
        // ANOTHER_USER tries to change the vibe and should fail
        vm.prank(ANOTHER_USER);
        vm.expectRevert(VibeNft.VibeNft__NotApproved.selector);
        vibeNft.changeVibe(0);
    }

    /**
     * @notice Tests that an approved address can change the vibe
     */
    function testApprovedCanChangeVibe() public {
        // USER mints an NFT and approves ANOTHER_USER
        vm.startPrank(USER);
        vibeNft.mintNft();
        vibeNft.approve(ANOTHER_USER, 0);
        vm.stopPrank();
        
        // ANOTHER_USER should be able to change the vibe
        vm.prank(ANOTHER_USER);
        vibeNft.changeVibe(0);
        
        // Verify the vibe was changed
        assertEq(vibeNft.tokenURI(0), WINK_JSON_URI);
    }

    /**
     * @notice Tests that changing vibe toggles between states
     */
    function testChangeVibeTogglesBetweenStates() public {
        // Initial mint and URI
        vm.prank(USER);
        vibeNft.mintNft();
        string memory initialUri = vibeNft.tokenURI(0);
        
        // First change (should be wink)
        vm.prank(USER);
        vibeNft.changeVibe(0);
        assertEq(vibeNft.tokenURI(0), WINK_JSON_URI);
        
        // Second change (should be back to smile)
        vm.prank(USER);
        vibeNft.changeVibe(0);
        assertEq(vibeNft.tokenURI(0), initialUri);
    }
    
    /**
     * @notice Tests that querying a non-existent token URI reverts
     */
    function testNonExistentTokenUriReverts() public {
        uint256 nonExistentTokenId = 999;
        vm.expectRevert();
        vibeNft.tokenURI(nonExistentTokenId);
    }
    
    /**
     * @notice Tests multiple mints and vibe changes
     */
    function testMultipleMintsAndChanges() public {
        // Mint several tokens to different users
        vm.prank(USER);
        vibeNft.mintNft(); // Token ID 0
        
        vm.prank(ANOTHER_USER);
        vibeNft.mintNft(); // Token ID 1
        
        vm.prank(USER);
        vibeNft.mintNft(); // Token ID 2
        
        // Change vibes on token 0 and 2 (owned by USER)
        vm.startPrank(USER);
        vibeNft.changeVibe(0);
        vibeNft.changeVibe(2);
        vm.stopPrank();
        
        // Change vibe on token 1 (owned by ANOTHER_USER)
        vm.prank(ANOTHER_USER);
        vibeNft.changeVibe(1);
        
        // Verify all tokens have wink vibe
        assertEq(vibeNft.tokenURI(0), WINK_JSON_URI);
        assertEq(vibeNft.tokenURI(1), WINK_JSON_URI);
        assertEq(vibeNft.tokenURI(2), WINK_JSON_URI);
    }
}
