// contracts/MyNFT.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {CBC721} from "../../token/CBC721/CBC721.sol";

contract MyNFT is CBC721 {
    constructor() CBC721("MyNFT", "MNFT") {}
}
