# Charity Donation NFT
## Overview

"Charity Donation NFT" is a Solidity smart contract leveraging the Ethereum blockchain. 
It enables users to make charitable donations in exchange for NFTs. 
The contract, utilizing OpenZeppelin's ERC721 and Ownable standards, offers unique features like a voting system for NFT holders and an impact reporting mechanism.

## Features
-NFT Minting on Donation: Users receive a unique NFT for each donation made, 
creating a tangible acknowledgment of their contribution.
-Voting System: NFT holders can vote on charity projects, allowing them to participate actively in the decision-making process.
-Project Tracking: The contract allows the owner to add new charity projects for voting, fostering community involvement.
-Donation and Impact Tracking: Tracks all donations and provides an impact report, enhancing transparency and accountability.

## How to Use
Donate: Send Ether to the contract to receive an NFT.
Vote: NFT holders can vote on listed charity projects.
Add Projects: The contract owner can list new projects for voting.
Impact Report: View total votes and number of projects for assessing the impact.

## Requirements

Solidity ^0.8.19
OpenZeppelin Contracts (ERC721, Ownable)
