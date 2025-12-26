// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.4.0) (token/CBC20/extensions/draft-CBC20Bridgeable.sol)

pragma solidity ^0.8.20;

import {CBC20} from "../CBC20.sol";
import {CBC165, ICBC165} from "../../../utils/introspection/CBC165.sol";
import {ICBC7802} from "../../../interfaces/draft-ICBC7802.sol";

/**
 * @dev CBC20 extension that implements the standard token interface according to
 * https://eips.ethereum.org/EIPS/eip-7802[CBC-7802].
 */
abstract contract CBC20Bridgeable is CBC20, CBC165, ICBC7802 {
    /// @dev Modifier to restrict access to the token bridge.
    modifier onlyTokenBridge() {
        // Token bridge should never be impersonated using a relayer/forwarder. Using msg.sender is preferable to
        // _msgSender() for security reasons.
        _checkTokenBridge(msg.sender);
        _;
    }

    /// @inheritdoc CBC165
    function supportsInterface(bytes4 interfaceId) public view virtual override(CBC165, ICBC165) returns (bool) {
        return interfaceId == type(ICBC7802).interfaceId || super.supportsInterface(interfaceId);
    }

    /**
     * @dev See {ICBC7802-crosschainMint}. Emits a {ICBC7802-CrosschainMint} event.
     */
    function crosschainMint(address to, uint256 value) public virtual override onlyTokenBridge {
        _mint(to, value);
        emit CrosschainMint(to, value, _msgSender());
    }

    /**
     * @dev See {ICBC7802-crosschainBurn}. Emits a {ICBC7802-CrosschainBurn} event.
     */
    function crosschainBurn(address from, uint256 value) public virtual override onlyTokenBridge {
        _burn(from, value);
        emit CrosschainBurn(from, value, _msgSender());
    }

    /**
     * @dev Checks if the caller is a trusted token bridge. MUST revert otherwise.
     *
     * Developers should implement this function using an access control mechanism that allows
     * customizing the list of allowed senders. Consider using {AccessControl} or {AccessManaged}.
     */
    function _checkTokenBridge(address caller) internal virtual;
}
