// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.4.0) (token/CBC20/extensions/CBC1363.sol)

pragma solidity ^0.8.20;

import {CBC20} from "../CBC20.sol";
import {ICBC165, CBC165} from "../../../utils/introspection/CBC165.sol";
import {ICBC1363} from "../../../interfaces/ICBC1363.sol";
import {CBC1363Utils} from "../utils/CBC1363Utils.sol";

/**
 * @title CBC1363
 * @dev Extension of {CBC20} tokens that adds support for code execution after transfers and approvals
 * on recipient contracts. Calls after transfers are enabled through the {CBC1363-transferAndCall} and
 * {CBC1363-transferFromAndCall} methods while calls after approvals can be made with {CBC1363-approveAndCall}
 *
 * _Available since v5.1._
 */
abstract contract CBC1363 is CBC20, CBC165, ICBC1363 {
    /**
     * @dev Indicates a failure within the {transfer} part of a transferAndCall operation.
     * @param receiver Address to which tokens are being transferred.
     * @param value Amount of tokens to be transferred.
     */
    error CBC1363TransferFailed(address receiver, uint256 value);

    /**
     * @dev Indicates a failure within the {transferFrom} part of a transferFromAndCall operation.
     * @param sender Address from which to send tokens.
     * @param receiver Address to which tokens are being transferred.
     * @param value Amount of tokens to be transferred.
     */
    error CBC1363TransferFromFailed(address sender, address receiver, uint256 value);

    /**
     * @dev Indicates a failure within the {approve} part of a approveAndCall operation.
     * @param spender Address which will spend the funds.
     * @param value Amount of tokens to be spent.
     */
    error CBC1363ApproveFailed(address spender, uint256 value);

    /// @inheritdoc ICBC165
    function supportsInterface(bytes4 interfaceId) public view virtual override(CBC165, ICBC165) returns (bool) {
        return interfaceId == type(ICBC1363).interfaceId || super.supportsInterface(interfaceId);
    }

    /**
     * @dev Moves a `value` amount of tokens from the caller's account to `to`
     * and then calls {ICBC1363Receiver-onTransferReceived} on `to`. Returns a flag that indicates
     * if the call succeeded.
     *
     * Requirements:
     *
     * - The target has code (i.e. is a contract).
     * - The target `to` must implement the {ICBC1363Receiver} interface.
     * - The target must return the {ICBC1363Receiver-onTransferReceived} selector to accept the transfer.
     * - The internal {transfer} must succeed (returned `true`).
     */
    function transferAndCall(address to, uint256 value) public returns (bool) {
        return transferAndCall(to, value, "");
    }

    /**
     * @dev Variant of {transferAndCall} that accepts an additional `data` parameter with
     * no specified format.
     */
    function transferAndCall(address to, uint256 value, bytes memory data) public virtual returns (bool) {
        if (!transfer(to, value)) {
            revert CBC1363TransferFailed(to, value);
        }
        CBC1363Utils.checkOnCBC1363TransferReceived(_msgSender(), _msgSender(), to, value, data);
        return true;
    }

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to` using the allowance mechanism
     * and then calls {ICBC1363Receiver-onTransferReceived} on `to`. Returns a flag that indicates
     * if the call succeeded.
     *
     * Requirements:
     *
     * - The target has code (i.e. is a contract).
     * - The target `to` must implement the {ICBC1363Receiver} interface.
     * - The target must return the {ICBC1363Receiver-onTransferReceived} selector to accept the transfer.
     * - The internal {transferFrom} must succeed (returned `true`).
     */
    function transferFromAndCall(address from, address to, uint256 value) public returns (bool) {
        return transferFromAndCall(from, to, value, "");
    }

    /**
     * @dev Variant of {transferFromAndCall} that accepts an additional `data` parameter with
     * no specified format.
     */
    function transferFromAndCall(
        address from,
        address to,
        uint256 value,
        bytes memory data
    ) public virtual returns (bool) {
        if (!transferFrom(from, to, value)) {
            revert CBC1363TransferFromFailed(from, to, value);
        }
        CBC1363Utils.checkOnCBC1363TransferReceived(_msgSender(), from, to, value, data);
        return true;
    }

    /**
     * @dev Sets a `value` amount of tokens as the allowance of `spender` over the
     * caller's tokens and then calls {ICBC1363Spender-onApprovalReceived} on `spender`.
     * Returns a flag that indicates if the call succeeded.
     *
     * Requirements:
     *
     * - The target has code (i.e. is a contract).
     * - The target `spender` must implement the {ICBC1363Spender} interface.
     * - The target must return the {ICBC1363Spender-onApprovalReceived} selector to accept the approval.
     * - The internal {approve} must succeed (returned `true`).
     */
    function approveAndCall(address spender, uint256 value) public returns (bool) {
        return approveAndCall(spender, value, "");
    }

    /**
     * @dev Variant of {approveAndCall} that accepts an additional `data` parameter with
     * no specified format.
     */
    function approveAndCall(address spender, uint256 value, bytes memory data) public virtual returns (bool) {
        if (!approve(spender, value)) {
            revert CBC1363ApproveFailed(spender, value);
        }
        CBC1363Utils.checkOnCBC1363ApprovalReceived(_msgSender(), spender, value, data);
        return true;
    }
}
