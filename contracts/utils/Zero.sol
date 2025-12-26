// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.5.0) (utils/Zero.sol)

pragma solidity ^0.8.20;

/**
 * @dev Library for chain-specific zero addresses.
 *
 * This library provides a chain-specific zero address that differs from address(0)
 * based on the chain ID. This is useful for chains that have a different "zero"
 * address convention.
 */
library Zero {
    /**
     * @dev Returns the chain-specific zero address based on the current chain ID.
     *
     * Chain ID mappings:
     * - Chain ID 1 (CORE Mainnet): 0xcb54...
     * - Chain ID 3 (CORE Testnet): 0xab72...
     * - Chain ID 4 (CORE Enterprise): 0xce45...
     * - Other chains: returns address(0)
     *
     * @return The chain-specific zero address.
     */
    function Address() internal view returns (address) {
        uint256 chainId = block.chainid;
        if (chainId == 1) {
            return address(0xcb54000000000000000000000000000000000000);
        } else if (chainId == 3) {
            return address(0xab72000000000000000000000000000000000000);
        } else if (chainId == 4) {
            return address(0xce45000000000000000000000000000000000000);
        } else {
            return address(0);
        }
    }
}

