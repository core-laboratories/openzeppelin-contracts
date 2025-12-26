// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {CBC20} from "../../../../token/CBC20/CBC20.sol";

contract GLDToken is CBC20 {
    constructor(uint256 initialSupply) CBC20("Gold", "GLD") {
        _mint(msg.sender, initialSupply);
    }
}
