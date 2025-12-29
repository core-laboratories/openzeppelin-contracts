# CoreZeppelin

CoreZeppelin is OpenZeppelin version for Core Blockchain which is using EDDSA for signature verification in contrast to Ethereum and other EVM-based chains.

[![Github Release](https://img.shields.io/github/v/tag/OpenZeppelin/openzeppelin-contracts.svg?filter=v*&sort=semver&label=github)](https://github.com/OpenZeppelin/openzeppelin-contracts/releases/latest)
[![NPM Package](https://img.shields.io/npm/v/@openzeppelin/contracts.svg)](https://www.npmjs.org/package/@openzeppelin/contracts)
[![Coverage Status](https://codecov.io/gh/OpenZeppelin/openzeppelin-contracts/graph/badge.svg)](https://codecov.io/gh/OpenZeppelin/openzeppelin-contracts)
[![GitPOAPs](https://public-api.gitpoap.io/v1/repo/OpenZeppelin/openzeppelin-contracts/badge)](https://www.gitpoap.io/gh/OpenZeppelin/openzeppelin-contracts)
[![Docs](https://img.shields.io/badge/docs-%F0%9F%93%84-yellow)](https://docs.openzeppelin.com/contracts)
[![Forum](https://img.shields.io/badge/forum-%F0%9F%92%AC-yellow)](https://forum.openzeppelin.com/)

**A library for secure smart contract development.** Build on a solid foundation of community-vetted code.

* Implementations of standards like [ERC20](https://docs.openzeppelin.com/contracts/erc20) and [ERC721](https://docs.openzeppelin.com/contracts/erc721).
* Flexible [role-based permissioning](https://docs.openzeppelin.com/contracts/access-control) scheme.
* Reusable [Solidity components](https://docs.openzeppelin.com/contracts/utilities) to build custom contracts and complex decentralized systems.

:mage: **Not sure how to get started?** Check out [Contracts Wizard](https://wizard.openzeppelin.com/) — an interactive smart contract generator.

> [!IMPORTANT]
> OpenZeppelin Contracts uses semantic versioning to communicate backwards compatibility of its API and storage layout. For upgradeable contracts, the storage layout of different major versions should be assumed incompatible, for example, it is unsafe to upgrade from 4.9.3 to 5.0.0. Learn more at [Backwards Compatibility](https://docs.openzeppelin.com/contracts/backwards-compatibility).

## Overview

### Release tags

We use NPM tags to clearly distinguish between audited and non-audited versions of our package:

| Tag        | Purpose                  | Description                                                                                                                                                                   |
| :--------- | :----------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **latest** | ✅ Audited releases      | Stable, audited versions of the package. This is the **default** version installed when users run `npm install @openzeppelin/contracts`.                                      |
| **dev**    | 🧪 Final but not audited | Versions that are finalized and feature-complete but have **not yet been audited**. This version is fully tested, can be used in production and is covered by the bug bounty. |
| **next**   | 🚧 Release candidates    | Pre-release versions that are **not final**. Used for testing and validation before the version becomes a final `dev` or `latest` release.                                    |

### Installation

#### Hardhat (npm)

```bash
npm install @corezeppelin/contracts
```

→ Installs the latest audited release (`latest`).

```bash
npm install @corezeppelin/contracts@dev
```

→ Installs the latest unaudited release (`dev`).

#### Foundry (git)

> [!WARNING]
> When installing via git, it is a common error to use the `master` branch. This is a development branch that should be avoided in favor of tagged releases. The release process involves security measures that the `master` branch does not guarantee.
> [!WARNING]
> Foundry installs the latest version initially, but subsequent `forge update` commands will use the `master` branch.

```bash
forge install OpenZeppelin/openzeppelin-contracts
```

Add `@openzeppelin/contracts/=lib/openzeppelin-contracts/contracts/` in `remappings.txt`.

### Usage

Once installed, you can use the contracts in the library by importing them:

```solidity
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyCollectible is ERC721 {
    constructor() ERC721("MyCollectible", "MCO") {
    }
}
```

_If you're new to smart contract development, head to [Developing Smart Contracts](https://docs.openzeppelin.com/learn/developing-smart-contracts) to learn about creating a new project and compiling your contracts._

To keep your system secure, you should **always** use the installed code as-is, and neither copy-paste it from online sources nor modify it yourself. The library is designed so that only the contracts and functions you use are deployed, so you don't need to worry about it needlessly increasing gas costs.

## ERC → CBC Aliases

This library provides CBC (Core Blockchain) naming conventions as aliases for ERC standards, allowing you to use CBC naming (CBC20, CBC721, etc.) while maintaining full ERC compatibility.

### Aliases Overview

The alias approach allows you to use CBC naming while leveraging the existing ERC implementations. This provides:

* **Full compatibility** with ERC standards
* **CBC naming** for Core Blockchain ecosystem
* **No code duplication** - all functionality inherited
* **Easy maintenance** - single source of truth

### Approach: Import Aliases with Wrapper Contracts

We use Solidity's import aliasing feature combined with wrapper contracts to create CBC aliases:

```solidity
// contracts/token/CBC20/CBC20.sol
pragma solidity ^0.8.20;

import {ERC20 as CBC20Base} from "../ERC20/ERC20.sol";
import {IERC20 as ICBC20} from "../ERC20/IERC20.sol";

/**
 * @dev CBC20 is an alias for ERC20, providing Core Blockchain compatibility
 */
abstract contract CBC20 is CBC20Base {
    // All ERC20 functionality is available through inheritance
    // You can add CBC-specific functionality here if needed
}
```

**Key Benefits:**

* ✅ **Simple and clean** - Minimal boilerplate
* ✅ **No code duplication** - Inherits all functionality
* ✅ **Maintains full compatibility** - Works with all ERC20 tooling
* ✅ **Easy to maintain** - Changes to ERC20 automatically propagate
* ✅ **Type-safe** - Full Solidity type checking

### Development Guide

#### Step 1: Create Interface Aliases

Start with interface aliases - they're the simplest:

```solidity
// contracts/token/CBC20/ICBC20.sol
pragma solidity ^0.8.20;

import {IERC20} from "../ERC20/IERC20.sol";

/**
 * @title ICBC20
 * @dev Core Blockchain compatible ERC20 interface
 */
interface ICBC20 is IERC20 {
    // All IERC20 functions are inherited
}
```

#### Step 2: Create Contract Aliases

Create wrapper contracts that inherit from ERC implementations:

```solidity
// contracts/token/CBC20/CBC20.sol
pragma solidity ^0.8.20;

import {ERC20 as _ERC20} from "../ERC20/ERC20.sol";
import {ICBC20} from "./ICBC20.sol";
import {IERC20Metadata as ICBC20Metadata} from "../ERC20/extensions/IERC20Metadata.sol";

/**
 * @title CBC20
 * @dev Core Blockchain compatible ERC20 token implementation
 *
 * This contract is an alias for ERC20, providing the same functionality
 * under the CBC naming convention for Core Blockchain compatibility.
 */
abstract contract CBC20 is _ERC20, ICBC20, ICBC20Metadata {
    // All functionality inherited from ERC20
}
```

#### Step 3: Create Extension Aliases

For extensions, follow the same pattern:

```solidity
// contracts/token/CBC20/extensions/CBC20Permit.sol
pragma solidity ^0.8.20;

import {ERC20Permit as _ERC20Permit} from "../../ERC20/extensions/ERC20Permit.sol";
import {CBC20} from "../CBC20.sol";
import {ICBC20Permit} from "./ICBC20Permit.sol";

/**
 * @title CBC20Permit
 * @dev Core Blockchain compatible ERC20 Permit extension
 */
abstract contract CBC20Permit is CBC20, _ERC20Permit, ICBC20Permit {
    // All ERC20Permit functionality inherited
}
```

#### Step 4: Using CBC Aliases in Your Contracts

Once aliases are created, use them in your contracts:

```solidity
// contracts/MyToken.sol
pragma solidity ^0.8.20;

import {CBC20} from "./token/CBC20/CBC20.sol";
import {CBC20Permit} from "./token/CBC20/extensions/CBC20Permit.sol";

contract MyToken is CBC20, CBC20Permit {
    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply
    ) CBC20(name, symbol) CBC20Permit(name) {
        _mint(msg.sender, initialSupply);
    }
}
```

### Best Practices

1. **Keep Aliases Minimal** - Aliases should be thin wrappers without unnecessary overrides
2. **Document the Alias Relationship** - Always document that it's an alias in comments
3. **Use Consistent Naming** - Contract aliases: `CBC20`, `CBC721`, `CBC1155`; Interface aliases: `ICBC20`, `ICBC721`, `ICBC1155`
4. **Maintain Import Paths** - Keep ERC implementations as the source of truth
5. **Handle Extensions Properly** - Extensions should inherit from both the base alias and the extension

### File Structure

```text
contracts/
├── token/
│   ├── ERC20/              # Original ERC20 (keep as-is)
│   │   ├── ERC20.sol
│   │   └── IERC20.sol
│   └── CBC20/              # CBC alias directory
│       ├── CBC20.sol       # Wrapper contract
│       └── ICBC20.sol      # Interface wrapper
```

## Learn More

The guides in the [documentation site](https://docs.openzeppelin.com/contracts) will teach about different concepts, and how to use the related contracts that OpenZeppelin Contracts provides:

* [Access Control](https://docs.openzeppelin.com/contracts/access-control): decide who can perform each of the actions on your system.
* [Tokens](https://docs.openzeppelin.com/contracts/tokens): create tradeable assets or collectibles for popular ERC standards like ERC-20, ERC-721, ERC-1155, and ERC-6909.
* [Utilities](https://docs.openzeppelin.com/contracts/utilities): generic useful tools including non-overflowing math, signature verification, and trustless paying systems.

The [full API](https://docs.openzeppelin.com/contracts/api/token/ERC20) is also thoroughly documented, and serves as a great reference when developing your smart contract application. You can also ask for help or follow Contracts' development in the [community forum](https://forum.openzeppelin.com).

Finally, you may want to take a look at the [guides on our blog](https://blog.openzeppelin.com/), which cover several common use cases and good practices. The following articles provide great background reading, though please note that some of the referenced tools have changed, as the tooling in the ecosystem continues to rapidly evolve.

* [The Hitchhiker’s Guide to Smart Contracts in Ethereum](https://blog.openzeppelin.com/the-hitchhikers-guide-to-smart-contracts-in-ethereum-848f08001f05) will help you get an overview of the various tools available for smart contract development, and help you set up your environment.
* [A Gentle Introduction to Ethereum Programming, Part 1](https://blog.openzeppelin.com/a-gentle-introduction-to-ethereum-programming-part-1-783cc7796094) provides very useful information on an introductory level, including many basic concepts from the Ethereum platform.
* For a more in-depth dive, you may read the guide [Designing the Architecture for Your Ethereum Application](https://blog.openzeppelin.com/designing-the-architecture-for-your-ethereum-application-9cec086f8317), which discusses how to better structure your application and its relationship to the real world.

## Security

This project is maintained by [OpenZeppelin](https://openzeppelin.com) with the goal of providing a secure and reliable library of smart contract components for the ecosystem. We address security through risk management in various areas such as engineering and open source best practices, scoping and API design, multi-layered review processes, and incident response preparedness.

The [OpenZeppelin Contracts Security Center](https://contracts.openzeppelin.com/security) contains more details about the secure development process.

The security policy is detailed in [`SECURITY.md`](./SECURITY.md) as well, and specifies how you can report security vulnerabilities, which versions will receive security patches, and how to stay informed about them. We run a [bug bounty program on Immunefi](https://immunefi.com/bounty/openzeppelin) to reward the responsible disclosure of vulnerabilities.

The engineering guidelines we follow to promote project quality can be found in [`GUIDELINES.md`](./GUIDELINES.md).

Past audits can be found in [`audits/`](./audits).

Smart contracts are a nascent technology and carry a high level of technical risk and uncertainty. Although OpenZeppelin is well known for its security audits, using OpenZeppelin Contracts is not a substitute for a security audit.

OpenZeppelin Contracts is made available under the MIT License, which disclaims all warranties in relation to the project and which limits the liability of those that contribute and maintain the project, including OpenZeppelin. As set out further in the Terms, you acknowledge that you are solely responsible for any use of OpenZeppelin Contracts and you assume all risks associated with any such use.

## Contribute

OpenZeppelin Contracts exists thanks to its contributors. There are many ways you can participate and help build high quality software. Check out the [contribution guide](CONTRIBUTING.md)!

## License

OpenZeppelin Contracts is released under the [MIT License](LICENSE).

## Legal

Your use of this Project is governed by the terms found at [www.corezeppelin.com/tos](https://www.corezeppelin.com/tos) (the "Terms").
