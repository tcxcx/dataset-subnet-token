
# Solidity Contracts Explanation

This collection of Solidity contracts is designed to support a unique data marketplace. In this marketplace, users can purchase labeled datasets, and automatically distribute payments to all contributors of the data. The functionality provided by these contracts enables seamless interchain messaging, staking of ERC20 tokens, and equitable payment splitting among multiple payees. Below, we delve into the specifics of each contract and how they contribute to the ecosystem.

## Data Marketplace Overview

The data marketplace facilitates the buying and selling of labeled datasets. When a dataset is purchased, the payment is automatically split among all contributors to that dataset, thanks to the underlying smart contract mechanisms. This ensures a fair and transparent distribution of funds, incentivizing data contributors to provide high-quality datasets.

## Contracts Overview

### 1. `MerkleInterchainModel.sol`

This contract defines an interface `MerkeleInterchainSecurityProofs` for a security model to verify interchain messages.

#### Functions

- `moduleType()`: Returns an enum value representing the type of security model.
- `verify(bytes calldata _metadata, bytes calldata _message)`: Verifies an interchain message with the provided metadata.

#### Purpose

This contract provides interfaces for defining security models and hooks for interchain messaging. They can be used in an application that requires secure communication and verification of messages between different blockchain networks.

### 2. `MessageDispatch.sol`

Imports `MerkleInterchainModel` and `MessageDispatchHook` contracts and defines `PostOffice` interface.

#### Functions

- `dispatch(uint32 destinationDomain, bytes32 recipientAddress, bytes calldata messageBody)`: Dispatches an interchain message.
- `quoteDispatch(uint32 destinationDomain, bytes32 recipientAddress, bytes calldata messageBody)`: Quotes the fee for dispatching a message.

#### Purpose

This contract defines an interface for dispatching interchain messages through a mailbox system. It can be used in an application that needs to send messages or data across different blockchain networks.

### 3. `MessageDispatchHook.sol`

Defines `MessageDispatchHook` interface for hooks executed after message dispatch.

#### Functions

- `hookType()`: Returns the hook type.
- `supportsMetadata(bytes calldata metadata)`: Indicates support for the provided metadata.
- `postDispatch(bytes calldata metadata, bytes calldata message)`: Executes post-dispatch action.
- `quoteDispatch(bytes calldata metadata, bytes calldata message)`: Computes payment for the action.

#### Purpose

 This contract, ActivateSubnet, demonstrates how to interact with the PostOffice interface to send interchain messages. It can be used as a starting point for building an application that requires cross-chain communication.

### 4. `sender.sol` (`ActivateSubnet`)

Interacts with `PostOffice` to send interchain messages.

#### Function

- `sendMessage(address walletAddress)`: Sends a message to a recipient address.

#### Purpose

This contract, `ActivateSubnet`, demonstrates how to interact with the PostOffice interface to send interchain messages. It can be used as a starting point for building an application that requires cross-chain communication.


### 5. `staking.sol` (`SimpleStaking`)

Implements basic staking functionality for ERC20 tokens.

#### Functions

- `stake(address token, uint256 amount)`: Stakes ERC20 tokens.
- `unstake(address token, uint256 amount)`: Unstakes tokens.
- `getStakedBalance(address user)`: Retrieves total staked amount for a user.

#### Purpose

This contract provides a basic staking functionality for ERC20 tokens. It can be used in an application that incentivizes users to hold and stake tokens, such as a loyalty program or a governance system.


### 6. `transfer.sol` (`PaymentSplitter`)

Allows splitting payments among multiple payees with USDT ERC20 tokens.

#### Functions
- `setShares(address[] memory _payees, uint256[] memory _shares)`: Sets shares for each payee.
- `receiveUSDT(uint256 amount)`: Receives USDT tokens.
- `buy(uint256 amount)`: Allows buying into the contract with USDT.
- `distributeFunds()`: Distributes USDT balance among payees.

#### Purpose

This contract allows for splitting payments among multiple payees based on predefined shares.  It interacts with the USDT ERC20 token.  It can be used in an application that requires automated distribution of funds, such as a revenue sharing system or a crowdfunding platform.

## Conclusion

The described contracts facilitate various operations like interchain messaging, staking, and payment splitting, showcasing the versatility of Solidity for blockchain development.



## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
