// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {CBC20} from "../../token/CBC20/CBC20.sol";
import {Multicall} from "../../utils/Multicall.sol";

abstract contract CBC20MulticallMock is CBC20, Multicall {}
