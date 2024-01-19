# Charity Donation NFT

## Overview

The Charity Donation NFT is a Solidity smart contract designed for the Ethereum blockchain. This contract empowers users to donate to a charity and, in return, receive a unique Non-Fungible Token (NFT). It features a voting mechanism for NFT holders and an impact reporting system.

## Features

- **Donation and NFT Minting**: Users can easily contribute Ether to the contract and instantly receive a unique ERC-721 NFT.

- **Voting Mechanism**: NFT owners can actively participate in decision-making by casting votes on various charity projects.

- **Dynamic Project Addition**: The contract owner has the flexibility to dynamically introduce new charity projects for voting, fostering adaptability.

- **Transparent Impact Reporting**: The contract provides a clear and concise impact report, offering insights into the total number of votes and the available charity projects.

## Getting Started

### Running Locally

1. Clone the repository:

   ```bash
   git clone https://github.com/Gedion08/Decade/charity-donation-nft.git
   ```

2. Install dependencies:

   ```bash
   npm install
   ```

3. Deploy the contract and run a local server:

   ```bash
   truffle migrate
   npm run dev
   ```

4. Access the application at http://localhost:3000.

### Running on Remix IDE Online

1. Open the [Remix IDE](https://remix.ethereum.org/).

2. Create a new file and paste the contract code.

3. Compile and deploy the contract using the Remix interface.

4. Interact with the contract through Remix.

### Using a Testnet

1. Deploy the contract on a testnet.

2. Fund your Ethereum address with test Ether using a faucet.

3. Interact with the deployed contract on the testnet.

## Project Description

The Charity Donation NFT project seeks to merge the world of charitable giving with the exciting possibilities offered by blockchain technology. Users can make a difference by supporting charitable causes while also owning unique digital assets.

### Implementation Details

The project is implemented using the Solidity programming language and leverages the ERC-721 standard for Non-Fungible Tokens. Users can donate, mint NFTs, and engage in a voting process to influence charitable initiatives.

## Use Cases

- **Charity Fundraising**: Charities can leverage the contract to engage with the crypto community and raise funds transparently.

- **NFT Collectors**: NFT enthusiasts can acquire unique digital assets while contributing to philanthropic causes.

- **Impact Tracking**: Users can monitor the impact of their donations through the provided impact report.

## Benefits

- **Transparency**: The decentralized nature of blockchain ensures transparent and auditable transactions.

- **Engagement**: Users can actively participate in decision-making through the voting mechanism.

- **Accessibility**: The project can be easily run locally or on Remix IDE, making it accessible to a broader audience.

- **Innovation**: The combination of NFTs and charitable donations introduces a novel way to engage users in philanthropy.


## Requirements

Solidity ^0.8.19
OpenZeppelin Contracts (ERC721, Ownable)
