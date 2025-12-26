// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.5.0) (utils/ZeroCheck.sol)

pragma solidity ^0.8.20;

import "./Zero.sol";

/**
 * @dev Library for checking if an address is considered "zero" (either address(0) or the chain-specific zero).
 *
 * This library provides a consistent way to check for zero addresses across the codebase,
 * ensuring that both the standard zero address and the chain-specific zero address are handled.
 */
library ZeroCheck {
    /**
     * @dev Checks if an address is considered "zero" (either address(0) or the chain-specific zero).
     *
     * @param a The address to check.
     * @return true if the address is address(0) or the chain-specific zero address, false otherwise.
     */
    function isZero(address a) internal view returns (bool) {
        return a == address(0) || a == Zero.Address();
    }
}

