// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.4.0) (interfaces/IERC5805.sol)

pragma solidity >=0.8.4;

import {IVotes} from "../governance/utils/IVotes.sol";
import {ICBC6372} from "./ICBC6372.sol";

interface ICBC5805 is ICBC6372, IVotes {}
