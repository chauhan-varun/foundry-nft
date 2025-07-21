// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/**
 * @title PrimeNft
 * @author Varun Chauhan
 * @notice A simple ERC721 NFT contract that allows minting NFTs with custom URIs
 * @dev Implements standard ERC721 functionality with custom URI storage
 */
contract PrimeNft is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 token => string uri) private s_tokenToUri;

    /**
     * @notice Contract constructor
     * @dev Initializes the ERC721 token with name "PrimeNft" and symbol "PNFT"
     */
    constructor() ERC721("PrimeNft", "PNFT") {
        s_tokenCounter = 0;
    }

    /**
     * @notice Mints a new NFT with the specified URI
     * @dev Assigns the NFT to the caller and stores the URI
     * @param _uri The URI for the NFT metadata
     */
    function mintNft(string memory _uri) public {
        _mint(msg.sender, s_tokenCounter);
        s_tokenToUri[s_tokenCounter] = _uri;
        s_tokenCounter++;
    }

    /**
     * @notice Returns the URI for a given token ID
     * @dev Overrides the ERC721 tokenURI function
     * @param tokenId The ID of the token to query
     * @return The token's URI
     */
    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_tokenToUri[tokenId];
    }
}
