// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ICBC20} from "../../token/CBC20/ICBC20.sol";
import {ICBC20Metadata} from "../../token/CBC20/extensions/ICBC20Metadata.sol";

contract CBC20GetterHelper {
    event CBC20TotalSupply(ICBC20 token, uint256 totalSupply);
    event CBC20BalanceOf(ICBC20 token, address account, uint256 balanceOf);
    event CBC20Allowance(ICBC20 token, address owner, address spender, uint256 allowance);
    event CBC20Name(ICBC20Metadata token, string name);
    event CBC20Symbol(ICBC20Metadata token, string symbol);
    event CBC20Decimals(ICBC20Metadata token, uint8 decimals);

    function totalSupply(ICBC20 token) external {
        emit CBC20TotalSupply(token, token.totalSupply());
    }

    function balanceOf(ICBC20 token, address account) external {
        emit CBC20BalanceOf(token, account, token.balanceOf(account));
    }

    function allowance(ICBC20 token, address owner, address spender) external {
        emit CBC20Allowance(token, owner, spender, token.allowance(owner, spender));
    }

    function name(ICBC20Metadata token) external {
        emit CBC20Name(token, token.name());
    }

    function symbol(ICBC20Metadata token) external {
        emit CBC20Symbol(token, token.symbol());
    }

    function decimals(ICBC20Metadata token) external {
        emit CBC20Decimals(token, token.decimals());
    }
}
