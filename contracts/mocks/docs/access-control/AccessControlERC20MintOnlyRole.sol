// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {AccessControl} from "../../../access/AccessControl.sol";
import {CBC20} from "../../../token/CBC20/CBC20.sol";

contract AccessControlCBC20Mint is CBC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    constructor(address minter, address burner) CBC20("MyToken", "TKN") {
        _grantRole(MINTER_ROLE, minter);
        _grantRole(BURNER_ROLE, burner);
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public onlyRole(BURNER_ROLE) {
        _burn(from, amount);
    }
}
