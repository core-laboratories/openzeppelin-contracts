// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.5.0) (token/CBC1155/extensions/CBC1155Burnable.sol)

pragma solidity ^0.8.24;

import {CBC1155} from "../CBC1155.sol";

/**
 * @dev Extension of {CBC1155} that allows token holders to destroy both their
 * own tokens and those that they have been approved to use.
 */
abstract contract CBC1155Burnable is CBC1155 {
    function burn(address account, uint256 id, uint256 value) public virtual {
        if (account != _msgSender() && !isApprovedForAll(account, _msgSender())) {
            revert CBC1155MissingApprovalForAll(_msgSender(), account);
        }

        _burn(account, id, value);
    }

    function burnBatch(address account, uint256[] memory ids, uint256[] memory values) public virtual {
        if (account != _msgSender() && !isApprovedForAll(account, _msgSender())) {
            revert CBC1155MissingApprovalForAll(_msgSender(), account);
        }

        _burnBatch(account, ids, values);
    }
}
