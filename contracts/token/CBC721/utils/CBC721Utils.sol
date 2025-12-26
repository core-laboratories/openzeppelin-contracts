// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.5.0) (token/CBC721/utils/CBC721Utils.sol)

pragma solidity ^0.8.20;

import {ICBC721Receiver} from "../ICBC721Receiver.sol";
import {ICBC721Errors} from "../../../interfaces/draft-ICBC6093.sol";

/**
 * @dev Library that provides common CBC-721 utility functions.
 *
 * See https://eips.ethereum.org/EIPS/eip-721[CBC-721].
 *
 * _Available since v5.1._
 */
library CBC721Utils {
    /**
     * @dev Performs an acceptance check for the provided `operator` by calling {ICBC721Receiver-onCBC721Received}
     * on the `to` address. The `operator` is generally the address that initiated the token transfer (i.e. `msg.sender`).
     *
     * The acceptance call is not executed and treated as a no-op if the target address doesn't contain code (i.e. an EOA).
     * Otherwise, the recipient must implement {ICBC721Receiver-onCBC721Received} and return the acceptance magic value to accept
     * the transfer.
     */
    function checkOnCBC721Received(
        address operator,
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) internal {
        if (to.code.length > 0) {
            try ICBC721Receiver(to).onCBC721Received(operator, from, tokenId, data) returns (bytes4 retval) {
                if (retval != ICBC721Receiver.onCBC721Received.selector) {
                    // Token rejected
                    revert ICBC721Errors.CBC721InvalidReceiver(to);
                }
            } catch (bytes memory reason) {
                if (reason.length == 0) {
                    // non-ICBC721Receiver implementer
                    revert ICBC721Errors.CBC721InvalidReceiver(to);
                } else {
                    assembly ("memory-safe") {
                        revert(add(reason, 0x20), mload(reason))
                    }
                }
            }
        }
    }
}
