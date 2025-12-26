// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.4.0) (token/CBC20/utils/CBC1363Utils.sol)

pragma solidity ^0.8.20;

import {ICBC1363Receiver} from "../../../interfaces/ICBC1363Receiver.sol";
import {ICBC1363Spender} from "../../../interfaces/ICBC1363Spender.sol";

/**
 * @dev Library that provides common CBC-1363 utility functions.
 *
 * See https://eips.ethereum.org/EIPS/eip-1363[CBC-1363].
 */
library CBC1363Utils {
    /**
     * @dev Indicates a failure with the token `receiver`. Used in transfers.
     * @param receiver Address to which tokens are being transferred.
     */
    error CBC1363InvalidReceiver(address receiver);

    /**
     * @dev Indicates a failure with the token `spender`. Used in approvals.
     * @param spender Address that may be allowed to operate on tokens without being their owner.
     */
    error CBC1363InvalidSpender(address spender);

    /**
     * @dev Performs a call to {ICBC1363Receiver-onTransferReceived} on a target address.
     *
     * Requirements:
     *
     * - The target has code (i.e. is a contract).
     * - The target `to` must implement the {ICBC1363Receiver} interface.
     * - The target must return the {ICBC1363Receiver-onTransferReceived} selector to accept the transfer.
     */
    function checkOnCBC1363TransferReceived(
        address operator,
        address from,
        address to,
        uint256 value,
        bytes memory data
    ) internal {
        if (to.code.length == 0) {
            revert CBC1363InvalidReceiver(to);
        }

        try ICBC1363Receiver(to).onTransferReceived(operator, from, value, data) returns (bytes4 retval) {
            if (retval != ICBC1363Receiver.onTransferReceived.selector) {
                revert CBC1363InvalidReceiver(to);
            }
        } catch (bytes memory reason) {
            if (reason.length == 0) {
                revert CBC1363InvalidReceiver(to);
            } else {
                assembly ("memory-safe") {
                    revert(add(reason, 0x20), mload(reason))
                }
            }
        }
    }

    /**
     * @dev Performs a call to {ICBC1363Spender-onApprovalReceived} on a target address.
     *
     * Requirements:
     *
     * - The target has code (i.e. is a contract).
     * - The target `spender` must implement the {ICBC1363Spender} interface.
     * - The target must return the {ICBC1363Spender-onApprovalReceived} selector to accept the approval.
     */
    function checkOnCBC1363ApprovalReceived(
        address operator,
        address spender,
        uint256 value,
        bytes memory data
    ) internal {
        if (spender.code.length == 0) {
            revert CBC1363InvalidSpender(spender);
        }

        try ICBC1363Spender(spender).onApprovalReceived(operator, value, data) returns (bytes4 retval) {
            if (retval != ICBC1363Spender.onApprovalReceived.selector) {
                revert CBC1363InvalidSpender(spender);
            }
        } catch (bytes memory reason) {
            if (reason.length == 0) {
                revert CBC1363InvalidSpender(spender);
            } else {
                assembly ("memory-safe") {
                    revert(add(reason, 0x20), mload(reason))
                }
            }
        }
    }
}
