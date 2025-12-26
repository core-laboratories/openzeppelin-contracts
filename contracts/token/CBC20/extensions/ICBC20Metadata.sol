// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.4.0) (token/CBC20/extensions/ICBC20Metadata.sol)

pragma solidity >=0.6.2;

import {ICBC20} from "../ICBC20.sol";

/**
 * @dev Interface for the optional metadata functions from the CBC-20 standard.
 */
interface ICBC20Metadata is ICBC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}
