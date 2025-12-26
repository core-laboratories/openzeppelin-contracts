// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.5.0) (token/CBC721/extensions/CBC721Wrapper.sol)

pragma solidity ^0.8.24;

import {ICBC721, CBC721} from "../CBC721.sol";
import {ICBC721Receiver} from "../ICBC721Receiver.sol";

/**
 * @dev Extension of the CBC-721 token contract to support token wrapping.
 *
 * Users can deposit and withdraw an "underlying token" and receive a "wrapped token" with a matching tokenId. This is
 * useful in conjunction with other modules. For example, combining this wrapping mechanism with {CBC721Votes} will allow
 * the wrapping of an existing "basic" CBC-721 into a governance token.
 */
abstract contract CBC721Wrapper is CBC721, ICBC721Receiver {
    ICBC721 private immutable _underlying;

    /**
     * @dev The received CBC-721 token couldn't be wrapped.
     */
    error CBC721UnsupportedToken(address token);

    constructor(ICBC721 underlyingToken) {
        _underlying = underlyingToken;
    }

    /**
     * @dev Allow a user to deposit underlying tokens and mint the corresponding tokenIds.
     */
    function depositFor(address account, uint256[] memory tokenIds) public virtual returns (bool) {
        uint256 length = tokenIds.length;
        for (uint256 i = 0; i < length; ++i) {
            uint256 tokenId = tokenIds[i];

            // This is an "unsafe" transfer that doesn't call any hook on the receiver. With underlying() being trusted
            // (by design of this contract) and no other contracts expected to be called from there, we are safe.
            // slither-disable-next-line reentrancy-no-eth
            underlying().transferFrom(_msgSender(), address(this), tokenId); // forge-lint: disable-line(erc20-unchecked-transfer)
            _safeMint(account, tokenId);
        }

        return true;
    }

    /**
     * @dev Allow a user to burn wrapped tokens and withdraw the corresponding tokenIds of the underlying tokens.
     */
    function withdrawTo(address account, uint256[] memory tokenIds) public virtual returns (bool) {
        uint256 length = tokenIds.length;
        for (uint256 i = 0; i < length; ++i) {
            uint256 tokenId = tokenIds[i];
            // Setting an "auth" arguments enables the `_isAuthorized` check which verifies that the token exists
            // (from != 0). Therefore, it is not needed to verify that the return value is not 0 here.
            _update(address(0), tokenId, _msgSender());
            // Checks were already performed at this point, and there's no way to retake ownership or approval from
            // the wrapped tokenId after this point, so it's safe to remove the reentrancy check for the next line.
            // slither-disable-next-line reentrancy-no-eth
            underlying().safeTransferFrom(address(this), account, tokenId);
        }

        return true;
    }

    /**
     * @dev Overrides {ICBC721Receiver-onCBC721Received} to allow minting on direct CBC-721 transfers to
     * this contract.
     *
     * In case there's data attached, it validates that the operator is this contract, so only trusted data
     * is accepted from {depositFor}.
     *
     * WARNING: Doesn't work with unsafe transfers (eg. {ICBC721-transferFrom}). Use {CBC721Wrapper-_recover}
     * for recovering in that scenario.
     */
    function onCBC721Received(address, address from, uint256 tokenId, bytes memory) public virtual returns (bytes4) {
        if (address(underlying()) != _msgSender()) {
            revert CBC721UnsupportedToken(_msgSender());
        }
        _safeMint(from, tokenId);
        return ICBC721Receiver.onCBC721Received.selector;
    }

    /**
     * @dev Mint a wrapped token to cover any underlyingToken that would have been transferred by mistake. Internal
     * function that can be exposed with access control if desired.
     */
    function _recover(address account, uint256 tokenId) internal virtual returns (uint256) {
        address owner = underlying().ownerOf(tokenId);
        if (owner != address(this)) {
            revert CBC721IncorrectOwner(address(this), tokenId, owner);
        }
        _safeMint(account, tokenId);
        return tokenId;
    }

    /**
     * @dev Returns the underlying token.
     */
    function underlying() public view virtual returns (ICBC721) {
        return _underlying;
    }
}
