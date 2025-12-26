// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {CBC721} from "../../token/CBC721/CBC721.sol";
import {CBC721Consecutive} from "../../token/CBC721/extensions/CBC721Consecutive.sol";
import {CBC721Enumerable} from "../../token/CBC721/extensions/CBC721Enumerable.sol";

contract CBC721ConsecutiveEnumerableMock is CBC721Consecutive, CBC721Enumerable {
    constructor(
        string memory name,
        string memory symbol,
        address[] memory receivers,
        uint96[] memory amounts
    ) CBC721(name, symbol) {
        for (uint256 i = 0; i < receivers.length; ++i) {
            _mintConsecutive(receivers[i], amounts[i]);
        }
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override(CBC721, CBC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function _ownerOf(uint256 tokenId) internal view virtual override(CBC721, CBC721Consecutive) returns (address) {
        return super._ownerOf(tokenId);
    }

    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal virtual override(CBC721Consecutive, CBC721Enumerable) returns (address) {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 amount) internal virtual override(CBC721, CBC721Enumerable) {
        super._increaseBalance(account, amount);
    }
}
