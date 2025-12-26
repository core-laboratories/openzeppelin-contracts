// contracts/GameItem.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {CBC721URIStorage, CBC721} from "../../../../token/CBC721/extensions/CBC721URIStorage.sol";

contract GameItem is CBC721URIStorage {
    uint256 private _nextTokenId;

    constructor() CBC721("GameItem", "ITM") {}

    function awardItem(address player, string memory tokenURI) public returns (uint256) {
        uint256 tokenId = _nextTokenId++;
        _mint(player, tokenId);
        _setTokenURI(tokenId, tokenURI);

        return tokenId;
    }
}
