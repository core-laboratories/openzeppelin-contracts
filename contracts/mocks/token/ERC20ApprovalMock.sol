// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {CBC20} from "../../token/CBC20/CBC20.sol";

abstract contract CBC20ApprovalMock is CBC20 {
    function _approve(address owner, address spender, uint256 amount, bool) internal virtual override {
        super._approve(owner, spender, amount, true);
    }
}
