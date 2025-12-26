// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.4.0) (interfaces/draft-IERC7674.sol)

pragma solidity >=0.6.2;

import {ICBC20} from "./ICBC20.sol";

/**
 * @dev Temporary Approval Extension for ERC-20 (https://github.com/ethereum/ERCs/pull/358[ERC-7674])
 */
interface ICBC7674 is ICBC20 {
    /**
     * @dev Set the temporary allowance, allowing `spender` to withdraw (within the same transaction) assets
     * held by the caller.
     */
    function temporaryApprove(address spender, uint256 value) external returns (bool success);
}
