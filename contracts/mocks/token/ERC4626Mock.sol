// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ICBC20, CBC20} from "../../token/CBC20/CBC20.sol";
import {ERC4626} from "../../token/CBC20/extensions/ERC4626.sol";

contract ERC4626Mock is ERC4626 {
    constructor(address underlying) CBC20("ERC4626Mock", "E4626M") ERC4626(ICBC20(underlying)) {}

    function mint(address account, uint256 amount) external {
        _mint(account, amount);
    }

    function burn(address account, uint256 amount) external {
        _burn(account, amount);
    }
}
