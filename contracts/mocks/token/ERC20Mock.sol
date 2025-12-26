// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {CBC20} from "../../token/CBC20/CBC20.sol";

contract CBC20Mock is CBC20 {
    constructor() CBC20("CBC20Mock", "E20M") {}

    function mint(address account, uint256 amount) external {
        _mint(account, amount);
    }

    function burn(address account, uint256 amount) external {
        _burn(account, amount);
    }
}
