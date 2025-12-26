// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {CBC20} from "../../token/CBC20/CBC20.sol";

abstract contract CBC20DecimalsMock is CBC20 {
    uint8 private immutable _decimals;

    constructor(uint8 decimals_) {
        _decimals = decimals_;
    }

    function decimals() public view override returns (uint8) {
        return _decimals;
    }
}
