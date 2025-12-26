// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.4.0) (token/CBC721/ICBC721Receiver.sol)

pragma solidity >=0.5.0;

/**
 * @title CBC-721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from CBC-721 asset contracts.
 */
interface ICBC721Receiver {
    /**
     * @dev Whenever an {ICBC721} `tokenId` token is transferred to this contract via {ICBC721-safeTransferFrom}
     * by `operator` from `from`, this function is called.
     *
     * It must return its Solidity selector to confirm the token transfer.
     * If any other value is returned or the interface is not implemented by the recipient, the transfer will be
     * reverted.
     *
     * The selector can be obtained in Solidity with `ICBC721Receiver.onCBC721Received.selector`.
     */
    function onCBC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}
