// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {CBC20FlashMint} from "../../token/CBC20/extensions/CBC20FlashMint.sol";

abstract contract CBC20FlashMintMock is CBC20FlashMint {
    uint256 _flashFeeAmount;
    address _flashFeeReceiverAddress;

    function setFlashFee(uint256 amount) public {
        _flashFeeAmount = amount;
    }

    function _flashFee(address, uint256) internal view override returns (uint256) {
        return _flashFeeAmount;
    }

    function setFlashFeeReceiver(address receiver) public {
        _flashFeeReceiverAddress = receiver;
    }

    function _flashFeeReceiver() internal view override returns (address) {
        return _flashFeeReceiverAddress;
    }
}
