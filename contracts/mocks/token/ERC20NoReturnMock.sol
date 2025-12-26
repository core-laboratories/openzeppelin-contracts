// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {CBC20} from "../../token/CBC20/CBC20.sol";

abstract contract CBC20NoReturnMock is CBC20 {
    function transfer(address to, uint256 amount) public override returns (bool) {
        // forge-lint: disable-next-line(erc20-unchecked-transfer)
        super.transfer(to, amount);
        assembly {
            return(0, 0)
        }
    }

    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        // forge-lint: disable-next-line(erc20-unchecked-transfer)
        super.transferFrom(from, to, amount);
        assembly {
            return(0, 0)
        }
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        super.approve(spender, amount);
        assembly {
            return(0, 0)
        }
    }
}
