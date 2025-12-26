// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {CBC20} from "../../../token/CBC20/CBC20.sol";
import {CBC20Permit} from "../../../token/CBC20/extensions/CBC20Permit.sol";
import {CBC20Votes} from "../../../token/CBC20/extensions/CBC20Votes.sol";
import {Nonces} from "../../../utils/Nonces.sol";

contract MyTokenTimestampBased is CBC20, CBC20Permit, CBC20Votes {
    constructor() CBC20("MyTokenTimestampBased", "MTK") CBC20Permit("MyTokenTimestampBased") {}

    // Overrides IERC6372 functions to make the token & governor timestamp-based

    function clock() public view override returns (uint48) {
        return uint48(block.timestamp);
    }

    // solhint-disable-next-line func-name-mixedcase
    function CLOCK_MODE() public pure override returns (string memory) {
        return "mode=timestamp";
    }

    // The functions below are overrides required by Solidity.

    function _update(address from, address to, uint256 amount) internal override(CBC20, CBC20Votes) {
        super._update(from, to, amount);
    }

    function nonces(address owner) public view virtual override(CBC20Permit, Nonces) returns (uint256) {
        return super.nonces(owner);
    }
}
