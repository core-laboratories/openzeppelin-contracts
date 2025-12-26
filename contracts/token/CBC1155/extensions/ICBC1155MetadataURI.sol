// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.4.0) (token/CBC1155/extensions/ICBC1155MetadataURI.sol)

pragma solidity >=0.6.2;

import {ICBC1155} from "../ICBC1155.sol";

/**
 * @dev Interface of the optional CBC1155MetadataExtension interface, as defined
 * in the https://eips.ethereum.org/EIPS/eip-1155#metadata-extensions[CBC].
 */
interface ICBC1155MetadataURI is ICBC1155 {
    /**
     * @dev Returns the URI for token type `id`.
     *
     * If the `\{id\}` substring is present in the URI, it must be replaced by
     * clients with the actual token type ID.
     */
    function uri(uint256 id) external view returns (string memory);
}
