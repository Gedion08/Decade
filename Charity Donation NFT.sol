// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Charity Donation NFT
 * This smart contract allows users to donate to a charity and receive an NFT in return.
 * It also includes a voting mechanism for NFT holders and an impact reporting system.
 */
contract CharityDonationNFT is ERC721, Ownable {
    uint256 public tokenIdCounter;
    address public charityAddress;
    uint256 public totalDonations;
    string public tokenBaseURI;
    uint256 public totalVotes;

    struct Donation {
        address donor;
        uint256 amount;
        uint256 timestamp;
    }
    
    struct Project {
        string description;
        uint256 voteCount;
    }

    mapping(uint256 => Donation) public donations;
    Project[] public projects;

    // Constructor to initialize the NFT with name, symbol, charity address, and base URI
   constructor(
        string memory _name,
        string memory _symbol,
        address _charityAddress,
        string memory _baseURI
    ) ERC721(_name, _symbol) Ownable() {
        charityAddress = _charityAddress;
        tokenBaseURI = _baseURI;
    }
    // Function to allow users to donate and receive an NFT
    function donate() external payable {
        require(msg.value > 0, "Donation amount must be greater than 0");

        uint256 tokenId = tokenIdCounter;
        tokenIdCounter++;
        
        _mint(msg.sender, tokenId);
        
        donations[tokenId] = Donation(msg.sender, msg.value, block.timestamp);
        totalDonations += msg.value;
    }

    // Function for NFT owners to vote on charity projects
    function vote(uint256 _tokenId, uint256 _projectId) external {
        require(ownerOf(_tokenId) == msg.sender, "You do not own this NFT");
        require(_projectId < projects.length, "Invalid project ID");

        projects[_projectId].voteCount++;
        totalVotes++;
    }

    // Function to add a new project for voting
    function addProject(string memory _description) external onlyOwner {
        projects.push(Project(_description, 0));
    }

    // Function to provide an impact report
    function getImpactReport() external view returns (uint256, uint256) {
        // Example implementation - modify as needed
        uint256 numberOfProjects = projects.length;
        return (totalVotes, numberOfProjects);
    }
}
