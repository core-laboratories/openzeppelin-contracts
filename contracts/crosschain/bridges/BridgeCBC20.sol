// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {ICBC20, SafeCBC20} from "../../token/CBC20/utils/SafeCBC20.sol";
import {BridgeCBC20Core} from "./BridgeCBC20Core.sol";

/**
 * @dev This is a variant of {BridgeCBC20Core} that implements the bridge logic for ERC-20 tokens that do not expose a
 * crosschain mint and burn mechanism. Instead, it takes custody of bridged assets.
 */
// slither-disable-next-line locked-ether
abstract contract BridgeCBC20 is BridgeCBC20Core {
    using SafeCBC20 for ICBC20;

    ICBC20 private immutable _token;

    constructor(ICBC20 token_) {
        _token = token_;
    }

    /// @dev Return the address of the CBC20 token this bridge operates on.
    function token() public view virtual returns (ICBC20) {
        return _token;
    }

    /// @dev "Locking" tokens is done by taking custody
    function _onSend(address from, uint256 amount) internal virtual override {
        token().safeTransferFrom(from, address(this), amount);
    }

    /// @dev "Unlocking" tokens is done by releasing custody
    function _onReceive(address to, uint256 amount) internal virtual override {
        token().safeTransfer(to, amount);
    }
}
