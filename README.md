# Foundry NFT Project

This project contains two NFT smart contracts built with Foundry:

- **PrimeNft**: Simple ERC721 NFT that allows minting NFTs with custom URIs
- **VibeNft**: On-chain SVG NFT that can switch between two states (Smile and Wink)

## Author
Varun Chauhan

## Project Structure

- `src/`: Smart contract source files
  - `PrimeNft.sol`: Basic NFT with custom URI
  - `VibeNft.sol`: On-chain SVG NFT with switchable states
- `test/`: 
  - `unit/`: Unit tests for contracts
  - `interactions/`: Tests for deployment and interaction scripts
- `script/`: Deployment and interaction scripts
- `img/`: SVG images used for the VibeNft

## Features

### PrimeNft
- Simple ERC721 implementation
- Mint NFTs with custom URIs
- Standard ERC721 functionality

### VibeNft
- On-chain SVG NFT
- SVG data stored directly in the contract
- "Vibe" can be changed between Smile and Wink states
- Token metadata generated on-chain with Base64 encoding

## Getting Started

### Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation)

### Installation

```shell
# Clone the repository
git clone https://github.com/chauhan-varun/foundry-nft
cd foundry-nft

# Install dependencies
forge install
```

## Usage

### Build

```shell
forge build
```

### Test

Run all tests:
```shell
forge test
```

Run specific tests:
```shell
# Run unit tests
forge test --match-path test/unit/**

# Run interaction tests
forge test --match-path test/interactions/**
```

### Deploy

Deploy PrimeNft:
```shell
forge script script/DeployPrimeNft.s.sol:DeployPrimeNft --rpc-url <your_rpc_url> --broadcast --private-key <your_private_key>
```

Deploy VibeNft:
```shell
forge script script/DeployVibeNft.s.sol:DeployVibeNft --rpc-url <your_rpc_url> --broadcast --private-key <your_private_key>
```

### Interact with NFTs

To mint a PrimeNft:
```shell
forge script script/Interactions.s.sol:Interactions --rpc-url <your_rpc_url> --broadcast --private-key <your_private_key>
```

## Foundry Documentation

For more information about Foundry:
- [Foundry Book](https://book.getfoundry.sh/)
- [Forge Standard Library](https://book.getfoundry.sh/reference/forge-std/)

## Tools

- **Forge**: Ethereum testing framework
- **Cast**: CLI for interacting with EVM smart contracts
- **Anvil**: Local Ethereum node
- **Chisel**: Solidity REPL
