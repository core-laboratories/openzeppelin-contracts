// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.4.0) (token/CBC1155/utils/CBC1155Utils.sol)

pragma solidity ^0.8.20;

import {ICBC1155Receiver} from "../ICBC1155Receiver.sol";
import {ICBC1155Errors} from "../../../interfaces/draft-ICBC6093.sol";

/**
 * @dev Library that provide common CBC-1155 utility functions.
 *
 * See https://eips.ethereum.org/EIPS/eip-1155[CBC-1155].
 *
 * _Available since v5.1._
 */
library CBC1155Utils {
    /**
     * @dev Performs an acceptance check for the provided `operator` by calling {ICBC1155Receiver-onCBC1155Received}
     * on the `to` address. The `operator` is generally the address that initiated the token transfer (i.e. `msg.sender`).
     *
     * The acceptance call is not executed and treated as a no-op if the target address doesn't contain code (i.e. an EOA).
     * Otherwise, the recipient must implement {ICBC1155Receiver-onCBC1155Received} and return the acceptance magic value to accept
     * the transfer.
     */
    function checkOnCBC1155Received(
        address operator,
        address from,
        address to,
        uint256 id,
        uint256 value,
        bytes memory data
    ) internal {
        if (to.code.length > 0) {
            try ICBC1155Receiver(to).onCBC1155Received(operator, from, id, value, data) returns (bytes4 response) {
                if (response != ICBC1155Receiver.onCBC1155Received.selector) {
                    // Tokens rejected
                    revert ICBC1155Errors.CBC1155InvalidReceiver(to);
                }
            } catch (bytes memory reason) {
                if (reason.length == 0) {
                    // non-ICBC1155Receiver implementer
                    revert ICBC1155Errors.CBC1155InvalidReceiver(to);
                } else {
                    assembly ("memory-safe") {
                        revert(add(reason, 0x20), mload(reason))
                    }
                }
            }
        }
    }

    /**
     * @dev Performs a batch acceptance check for the provided `operator` by calling {ICBC1155Receiver-onCBC1155BatchReceived}
     * on the `to` address. The `operator` is generally the address that initiated the token transfer (i.e. `msg.sender`).
     *
     * The acceptance call is not executed and treated as a no-op if the target address doesn't contain code (i.e. an EOA).
     * Otherwise, the recipient must implement {ICBC1155Receiver-onCBC1155Received} and return the acceptance magic value to accept
     * the transfer.
     */
    function checkOnCBC1155BatchReceived(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory values,
        bytes memory data
    ) internal {
        if (to.code.length > 0) {
            try ICBC1155Receiver(to).onCBC1155BatchReceived(operator, from, ids, values, data) returns (
                bytes4 response
            ) {
                if (response != ICBC1155Receiver.onCBC1155BatchReceived.selector) {
                    // Tokens rejected
                    revert ICBC1155Errors.CBC1155InvalidReceiver(to);
                }
            } catch (bytes memory reason) {
                if (reason.length == 0) {
                    // non-ICBC1155Receiver implementer
                    revert ICBC1155Errors.CBC1155InvalidReceiver(to);
                } else {
                    assembly ("memory-safe") {
                        revert(add(reason, 0x20), mload(reason))
                    }
                }
            }
        }
    }
}
