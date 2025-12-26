// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {CBC20Votes} from "../../token/CBC20/extensions/CBC20Votes.sol";
import {CBC721Votes} from "../../token/CBC721/extensions/CBC721Votes.sol";
import {SafeCast} from "../../utils/math/SafeCast.sol";

abstract contract CBC20VotesTimestampMock is CBC20Votes {
    function clock() public view virtual override returns (uint48) {
        return SafeCast.toUint48(block.timestamp);
    }

    // solhint-disable-next-line func-name-mixedcase
    function CLOCK_MODE() public view virtual override returns (string memory) {
        return "mode=timestamp";
    }
}

abstract contract CBC721VotesTimestampMock is CBC721Votes {
    function clock() public view virtual override returns (uint48) {
        return SafeCast.toUint48(block.timestamp);
    }

    // solhint-disable-next-line func-name-mixedcase
    function CLOCK_MODE() public view virtual override returns (string memory) {
        return "mode=timestamp";
    }
}
