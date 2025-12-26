// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.5.0) (token/CBC721/utils/CBC721Holder.sol)

pragma solidity ^0.8.20;

import {ICBC721Receiver} from "../ICBC721Receiver.sol";

/**
 * @dev Implementation of the {ICBC721Receiver} interface.
 *
 * Accepts all token transfers.
 * Make sure the contract is able to use its token with {ICBC721-safeTransferFrom}, {ICBC721-approve} or
 * {ICBC721-setApprovalForAll}.
 *
 * @custom:stateless
 */
abstract contract CBC721Holder is ICBC721Receiver {
    /**
     * @dev See {ICBC721Receiver-onCBC721Received}.
     *
     * Always returns `ICBC721Receiver.onCBC721Received.selector`.
     */
    function onCBC721Received(address, address, uint256, bytes memory) public virtual returns (bytes4) {
        return this.onCBC721Received.selector;
    }
}
