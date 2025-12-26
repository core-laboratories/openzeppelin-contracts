// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {CBC20} from "../../token/CBC20/CBC20.sol";

abstract contract CBC20ReturnFalseMock is CBC20 {
    function transfer(address, uint256) public pure override returns (bool) {
        return false;
    }

    function transferFrom(address, address, uint256) public pure override returns (bool) {
        return false;
    }

    function approve(address, uint256) public pure override returns (bool) {
        return false;
    }
}
