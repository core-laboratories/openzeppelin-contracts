// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.5.0) (token/CBC721/extensions/CBC721Royalty.sol)

pragma solidity ^0.8.24;

import {CBC721} from "../CBC721.sol";
import {ICBC165} from "../../../utils/introspection/CBC165.sol";
import {CBC2981} from "../../common/CBC2981.sol";

/**
 * @dev Extension of CBC-721 with the CBC-2981 NFT Royalty Standard, a standardized way to retrieve royalty payment
 * information.
 *
 * Royalty information can be specified globally for all token ids via {CBC2981-_setDefaultRoyalty}, and/or individually
 * for specific token ids via {CBC2981-_setTokenRoyalty}. The latter takes precedence over the first.
 *
 * IMPORTANT: CBC-2981 only specifies a way to signal royalty information and does not enforce its payment. See
 * https://eips.ethereum.org/EIPS/eip-2981#optional-royalty-payments[Rationale] in the CBC. Marketplaces are expected to
 * voluntarily pay royalties together with sales, but note that this standard is not yet widely supported.
 */
abstract contract CBC721Royalty is CBC2981, CBC721 {
    /// @inheritdoc ICBC165
    function supportsInterface(bytes4 interfaceId) public view virtual override(CBC721, CBC2981) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
