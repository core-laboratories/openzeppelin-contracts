// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.5.0) (token/CBC1155/utils/CBC1155Holder.sol)

pragma solidity ^0.8.20;

import {ICBC165, CBC165} from "../../../utils/introspection/CBC165.sol";
import {ICBC1155Receiver} from "../ICBC1155Receiver.sol";

/**
 * @dev Simple implementation of `ICBC1155Receiver` that will allow a contract to hold CBC-1155 tokens.
 *
 * IMPORTANT: When inheriting this contract, you must include a way to use the received tokens, otherwise they will be
 * stuck.
 *
 * @custom:stateless
 */
abstract contract CBC1155Holder is CBC165, ICBC1155Receiver {
    /// @inheritdoc ICBC165
    function supportsInterface(bytes4 interfaceId) public view virtual override(CBC165, ICBC165) returns (bool) {
        return interfaceId == type(ICBC1155Receiver).interfaceId || super.supportsInterface(interfaceId);
    }

    function onCBC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes memory
    ) public virtual override returns (bytes4) {
        return this.onCBC1155Received.selector;
    }

    function onCBC1155BatchReceived(
        address,
        address,
        uint256[] memory,
        uint256[] memory,
        bytes memory
    ) public virtual override returns (bytes4) {
        return this.onCBC1155BatchReceived.selector;
    }
}
