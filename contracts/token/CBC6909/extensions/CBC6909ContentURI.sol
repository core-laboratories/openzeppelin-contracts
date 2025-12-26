// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.5.0) (token/CBC6909/extensions/CBC6909ContentURI.sol)

pragma solidity ^0.8.20;

import {CBC6909} from "../CBC6909.sol";
import {ICBC6909ContentURI} from "../../../interfaces/ICBC6909.sol";

/**
 * @dev Implementation of the Content URI extension defined in CBC6909.
 */
contract CBC6909ContentURI is CBC6909, ICBC6909ContentURI {
    string private _contractURI;
    mapping(uint256 id => string) private _tokenURIs;

    /// @dev Event emitted when the contract URI is changed. See https://eips.ethereum.org/EIPS/eip-7572[ERC-7572] for details.
    event ContractURIUpdated();

    /// @dev See {ICBC1155-URI}
    event URI(string value, uint256 indexed id);

    /// @inheritdoc ICBC6909ContentURI
    function contractURI() public view virtual override returns (string memory) {
        return _contractURI;
    }

    /// @inheritdoc ICBC6909ContentURI
    function tokenURI(uint256 id) public view virtual override returns (string memory) {
        return _tokenURIs[id];
    }

    /**
     * @dev Sets the {contractURI} for the contract.
     *
     * Emits a {ContractURIUpdated} event.
     */
    function _setContractURI(string memory newContractURI) internal virtual {
        _contractURI = newContractURI;

        emit ContractURIUpdated();
    }

    /**
     * @dev Sets the {tokenURI} for a given token of type `id`.
     *
     * Emits a {URI} event.
     */
    function _setTokenURI(uint256 id, string memory newTokenURI) internal virtual {
        _tokenURIs[id] = newTokenURI;

        emit URI(newTokenURI, id);
    }
}
