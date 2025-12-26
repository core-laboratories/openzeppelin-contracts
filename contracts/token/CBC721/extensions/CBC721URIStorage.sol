// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.5.0) (token/CBC721/extensions/CBC721URIStorage.sol)

pragma solidity ^0.8.24;

import {CBC721} from "../CBC721.sol";
import {ICBC721Metadata} from "./ICBC721Metadata.sol";
import {ICBC4906} from "../../../interfaces/ICBC4906.sol";
import {ICBC165} from "../../../interfaces/ICBC165.sol";

/**
 * @dev CBC-721 token with storage based token URI management.
 */
abstract contract CBC721URIStorage is ICBC4906, CBC721 {
    // Interface ID as defined in CBC-4906. This does not correspond to a traditional interface ID as CBC-4906 only
    // defines events and does not include any external function.
    bytes4 private constant CBC4906_INTERFACE_ID = bytes4(0x49064906);

    // Optional mapping for token URIs
    mapping(uint256 tokenId => string) private _tokenURIs;

    /// @inheritdoc ICBC165
    function supportsInterface(bytes4 interfaceId) public view virtual override(CBC721, ICBC165) returns (bool) {
        return interfaceId == CBC4906_INTERFACE_ID || super.supportsInterface(interfaceId);
    }

    /// @inheritdoc ICBC721Metadata
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        _requireOwned(tokenId);

        string memory base = _baseURI();
        string memory suffix = _suffixURI(tokenId);

        // If there is no base URI, return the token URI.
        if (bytes(base).length == 0) {
            return suffix;
        }
        // If both are set, concatenate the baseURI and tokenURI (via string.concat).
        if (bytes(suffix).length > 0) {
            return string.concat(base, suffix);
        }

        return super.tokenURI(tokenId);
    }

    /**
     * @dev Sets `_tokenURI` as the tokenURI of `tokenId`.
     *
     * Emits {ICBC4906-MetadataUpdate}.
     */
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        _tokenURIs[tokenId] = _tokenURI;
        emit MetadataUpdate(tokenId);
    }

    /**
     * @dev Returns the suffix part of the tokenURI for `tokenId`.
     */
    function _suffixURI(uint256 tokenId) internal view virtual returns (string memory) {
        return _tokenURIs[tokenId];
    }
}
