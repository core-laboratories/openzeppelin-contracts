// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.5.0) (token/CBC721/extensions/CBC721Pausable.sol)

pragma solidity ^0.8.24;

import {CBC721} from "../CBC721.sol";
import {Pausable} from "../../../utils/Pausable.sol";

/**
 * @dev CBC-721 token with pausable token transfers, minting and burning.
 *
 * Useful for scenarios such as preventing trades until the end of an evaluation
 * period, or having an emergency switch for freezing all token transfers in the
 * event of a large bug.
 *
 * IMPORTANT: This contract does not include public pause and unpause functions. In
 * addition to inheriting this contract, you must define both functions, invoking the
 * {Pausable-_pause} and {Pausable-_unpause} internal functions, with appropriate
 * access control, e.g. using {AccessControl} or {Ownable}. Not doing so will
 * make the contract pause mechanism of the contract unreachable, and thus unusable.
 */
abstract contract CBC721Pausable is CBC721, Pausable {
    /**
     * @dev See {CBC721-_update}.
     *
     * Requirements:
     *
     * - the contract must not be paused.
     */
    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal virtual override whenNotPaused returns (address) {
        return super._update(to, tokenId, auth);
    }
}
