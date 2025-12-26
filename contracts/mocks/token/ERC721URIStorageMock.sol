// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {CBC721URIStorage} from "../../token/CBC721/extensions/CBC721URIStorage.sol";

abstract contract CBC721URIStorageMock is CBC721URIStorage {
    string private _baseTokenURI;

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string calldata newBaseTokenURI) public {
        _baseTokenURI = newBaseTokenURI;
    }
}
