// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ICBC20, CBC20} from "../../../token/CBC20/CBC20.sol";
import {CBC20Permit} from "../../../token/CBC20/extensions/CBC20Permit.sol";
import {CBC20Votes} from "../../../token/CBC20/extensions/CBC20Votes.sol";
import {CBC20Wrapper} from "../../../token/CBC20/extensions/CBC20Wrapper.sol";
import {Nonces} from "../../../utils/Nonces.sol";

contract MyTokenWrapped is CBC20, CBC20Permit, CBC20Votes, CBC20Wrapper {
    constructor(
        ICBC20 wrappedToken
    ) CBC20("MyTokenWrapped", "MTK") CBC20Permit("MyTokenWrapped") CBC20Wrapper(wrappedToken) {}

    // The functions below are overrides required by Solidity.

    function decimals() public view override(CBC20, CBC20Wrapper) returns (uint8) {
        return super.decimals();
    }

    function _update(address from, address to, uint256 amount) internal override(CBC20, CBC20Votes) {
        super._update(from, to, amount);
    }

    function nonces(address owner) public view virtual override(CBC20Permit, Nonces) returns (uint256) {
        return super.nonces(owner);
    }
}
