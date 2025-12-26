// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {CBC20} from "../CBC20.sol";
import {BridgeCBC20Core} from "../../../crosschain/bridges/BridgeCBC20Core.sol";

/**
 * @dev Extension of {CBC20} that makes it natively cross-chain using the CBC-7786 based {BridgeCBC20Core}.
 *
 * This extension makes the token compatible with counterparts on other chains, which can be:
 * * {CBC20Crosschain} instances,
 * * {CBC20} instances that are bridged using {BridgeCBC20},
 * * {CBC20Bridgeable} instances that are bridged using {BridgeCBC7802}.
 *
 * It is mostly equivalent to inheriting from both {CBC20Bridgeable} and {BridgeCBC7802}, and configuring them such
 * that:
 * * `token` (on the {BridgeCBC7802} side) is `address(this)`,
 * * `_checkTokenBridge` (on the {CBC20Bridgeable} side) is implemented such that it only accepts self-calls.
 */
// slither-disable-next-line locked-ether
abstract contract CBC20Crosschain is CBC20, BridgeCBC20Core {
    /// @dev Variant of {crosschainTransfer} that allows an authorized account (using CBC20 allowance) to operate on `from`'s assets.
    function crosschainTransferFrom(address from, bytes memory to, uint256 amount) public virtual returns (bytes32) {
        _spendAllowance(from, _msgSender(), amount);
        return _crosschainTransfer(from, to, amount);
    }

    /// @dev "Locking" tokens is achieved through burning
    function _onSend(address from, uint256 amount) internal virtual override {
        _burn(from, amount);
    }

    /// @dev "Unlocking" tokens is achieved through minting
    function _onReceive(address to, uint256 amount) internal virtual override {
        _mint(to, amount);
    }
}
