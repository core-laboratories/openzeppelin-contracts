// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {CBC721} from "../../token/CBC721/CBC721.sol";
import {CBC721Consecutive} from "../../token/CBC721/extensions/CBC721Consecutive.sol";
import {CBC721Pausable} from "../../token/CBC721/extensions/CBC721Pausable.sol";
import {CBC721Votes} from "../../token/CBC721/extensions/CBC721Votes.sol";
import {EIP712} from "../../utils/cryptography/EIP712.sol";

/**
 * @title CBC721ConsecutiveMock
 */
contract CBC721ConsecutiveMock is CBC721Consecutive, CBC721Pausable, CBC721Votes {
    uint96 private immutable _offset;

    constructor(
        string memory name,
        string memory symbol,
        uint96 offset,
        address[] memory delegates,
        address[] memory receivers,
        uint96[] memory amounts
    ) CBC721(name, symbol) EIP712(name, "1") {
        _offset = offset;

        for (uint256 i = 0; i < delegates.length; ++i) {
            _delegate(delegates[i], delegates[i]);
        }

        for (uint256 i = 0; i < receivers.length; ++i) {
            _mintConsecutive(receivers[i], amounts[i]);
        }
    }

    function _firstConsecutiveId() internal view virtual override returns (uint96) {
        return _offset;
    }

    function _ownerOf(uint256 tokenId) internal view virtual override(CBC721, CBC721Consecutive) returns (address) {
        return super._ownerOf(tokenId);
    }

    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal virtual override(CBC721Consecutive, CBC721Pausable, CBC721Votes) returns (address) {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 amount) internal virtual override(CBC721, CBC721Votes) {
        super._increaseBalance(account, amount);
    }
}

contract CBC721ConsecutiveNoConstructorMintMock is CBC721Consecutive {
    constructor(string memory name, string memory symbol) CBC721(name, symbol) {
        _mint(msg.sender, 0);
    }
}
