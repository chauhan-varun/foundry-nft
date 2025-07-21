// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

/**
 * @title VibeNft
 * @notice An ERC721 NFT contract that creates on-chain SVG NFTs with different "vibes"
 * @dev Implements ERC721 with dynamic on-chain metadata generation using Base64
 */
contract VibeNft is ERC721 {
    error ERC721Metadata__URI_QueryFor_NonExistentToken();
    error VibeNft__NotApproved();

    uint256 private s_tokenCounter;
    string private s_smiley;
    string private s_wink;

    /**
     * @notice Enum representing the possible vibes for an NFT
     * @dev Used to track and switch between different visual states
     */
    enum Vibe {
        Smile,
        Wink
    }

    mapping(uint256 token => Vibe vibe) private s_tokenToVibe;

    /**
     * @notice Contract constructor
     * @dev Initializes the ERC721 token with SVG data for different vibes
     * @param smiley The SVG data for the smiling face
     * @param wink The SVG data for the winking face
     */
    constructor(
        string memory smiley,
        string memory wink
    ) ERC721("VibeNft", "VNFT") {
        s_tokenCounter = 0;
        s_smiley = smiley;
        s_wink = wink;
    }

    /**
     * @notice Mints a new NFT to the caller
     * @dev Uses _safeMint to ensure receiver can handle ERC721 tokens
     */
    function mintNft() public {
        uint256 tokenCounter = s_tokenCounter;
        _safeMint(msg.sender, tokenCounter);
        s_tokenCounter++;
    }

    /**
     * @notice Returns the metadata URI for a given token ID
     * @dev Generates on-chain metadata with Base64 encoding
     * @param tokenId The ID of the token to query
     * @return The complete token URI with embedded metadata
     */
    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        if (ownerOf(tokenId) == address(0)) {
            revert ERC721Metadata__URI_QueryFor_NonExistentToken();
        }

        string memory imageUri = s_smiley;
        if (s_tokenToVibe[tokenId] == Vibe.Wink) {
            imageUri = s_wink;
        }

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        abi.encodePacked(
                            '{"name": "',
                            name(),
                            '", "description": "An NFT that reflects your vibe", "attributes": [{"trait_type": "Vibe", "value": "100"}], "image": "',
                            imageUri,
                            '"}'
                        )
                    )
                )
            );
    }

    /**
     * @notice Returns the base URI for the token metadata
     * @dev Overrides the ERC721 _baseURI function to use data URI format
     * @return The base URI string
     */
    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    /**
     * @notice Changes the vibe of an existing NFT
     * @dev Toggles between Smile and Wink states
     * @param tokenId The ID of the token to change
     */
    function changeVibe(uint256 tokenId) public {
        if (
            getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender
        ) {
            revert VibeNft__NotApproved();
        }
        if (s_tokenToVibe[tokenId] == Vibe.Smile) {
            s_tokenToVibe[tokenId] = Vibe.Wink;
        } else {
            s_tokenToVibe[tokenId] = Vibe.Smile;
        }
    }
}
