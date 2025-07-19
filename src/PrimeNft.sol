// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract PrimeNft is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 token => string uri) private s_tokenToUri;

    constructor() ERC721("PrimeNft", "PNFT") {
        s_tokenCounter = 0;
    }

    function mintNft(string memory _uri) public {
        _mint(msg.sender, s_tokenCounter);
        s_tokenToUri[s_tokenCounter] = _uri;
        s_tokenCounter++;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_tokenToUri[tokenId];
    }
}
