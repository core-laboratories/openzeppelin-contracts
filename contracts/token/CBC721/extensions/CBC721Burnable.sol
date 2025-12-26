// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.5.0) (token/CBC721/extensions/CBC721Burnable.sol)

pragma solidity ^0.8.24;

import {CBC721} from "../CBC721.sol";
import {Context} from "../../../utils/Context.sol";

/**
 * @title CBC-721 Burnable Token
 * @dev CBC-721 Token that can be burned (destroyed).
 */
abstract contract CBC721Burnable is Context, CBC721 {
    /**
     * @dev Burns `tokenId`. See {CBC721-_burn}.
     *
     * Requirements:
     *
     * - The caller must own `tokenId` or be an approved operator.
     */
    function burn(uint256 tokenId) public virtual {
        // Setting an "auth" arguments enables the `_isAuthorized` check which verifies that the token exists
        // (from != 0). Therefore, it is not needed to verify that the return value is not 0 here.
        _update(address(0), tokenId, _msgSender());
    }
}
