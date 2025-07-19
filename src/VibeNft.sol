// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract VibeNft is ERC721 {
    uint256 private s_tokenCounter;
    string private s_smiley;
    string private s_wink;

    enum Vibe {
        Smile,
        Wink
    }

    mapping(uint256 token => Vibe vibe) private s_tokenToVibe;

    constructor(
        string memory smiley,
        string memory wink
    ) ERC721("VibeNft", "VNFT") {
        s_tokenCounter = 0;
        s_smiley = smiley;
        s_wink = wink;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
        s_tokenToVibe[s_tokenCounter] = Vibe.Smile;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageUri;
        if (s_tokenToVibe[tokenId] == Vibe.Smile) {
            imageUri = s_smiley;
        } else {
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

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }
}
