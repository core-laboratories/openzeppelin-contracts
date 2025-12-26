// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.5.0) (token/CBC6909/extensions/CBC6909TokenSupply.sol)

pragma solidity ^0.8.20;

import {CBC6909} from "../CBC6909.sol";
import {ICBC6909TokenSupply} from "../../../interfaces/ICBC6909.sol";

/**
 * @dev Implementation of the Token Supply extension defined in CBC6909.
 * Tracks the total supply of each token id individually.
 */
contract CBC6909TokenSupply is CBC6909, ICBC6909TokenSupply {
    mapping(uint256 id => uint256) private _totalSupplies;

    /// @inheritdoc ICBC6909TokenSupply
    function totalSupply(uint256 id) public view virtual override returns (uint256) {
        return _totalSupplies[id];
    }

    /// @dev Override the `_update` function to update the total supply of each token id as necessary.
    function _update(address from, address to, uint256 id, uint256 amount) internal virtual override {
        super._update(from, to, id, amount);

        if (from == address(0)) {
            _totalSupplies[id] += amount;
        }
        if (to == address(0)) {
            unchecked {
                // amount <= _balances[from][id] <= _totalSupplies[id]
                _totalSupplies[id] -= amount;
            }
        }
    }
}
