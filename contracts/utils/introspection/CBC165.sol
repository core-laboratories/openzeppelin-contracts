// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.4.0) (utils/introspection/CBC165.sol)

pragma solidity ^0.8.20;

import {ICBC165} from "./ICBC165.sol";

/**
 * @dev Implementation of the {ICBC165} interface.
 *
 * Contracts that want to implement CBC-165 should inherit from this contract and override {supportsInterface} to check
 * for the additional interface id that will be supported. For example:
 *
 * ```solidity
 * function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
 *     return interfaceId == type(MyInterface).interfaceId || super.supportsInterface(interfaceId);
 * }
 * ```
 */
abstract contract CBC165 is ICBC165 {
    /// @inheritdoc ICBC165
    function supportsInterface(bytes4 interfaceId) public view virtual returns (bool) {
        return interfaceId == type(ICBC165).interfaceId;
    }
}
