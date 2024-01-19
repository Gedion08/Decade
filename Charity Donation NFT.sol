// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Charity Donation NFT
 * @dev This smart contract enables users to donate to a charity and receive an NFT in return.
 * It incorporates a voting mechanism for NFT holders and an impact reporting system.
 *
 *
 * Features:
 * - Users can donate Ether to receive a unique NFT (ERC721 token).
 * - NFT owners can vote on charity projects to participate in decision-making.
 * - The contract owner can add new charity projects for voting.
 * - Events are emitted for important state changes, allowing external systems to track activities.
 *
 * @author Your Name
 * @notice Please review and customize the contract according to specific use cases and requirements.
 */
contract CharityDonationNFT is ERC721, Ownable {
    /* State variables */
    uint256 public tokenIdCounter;
    address public charityAddress;
    uint256 public totalDonations;
    string public tokenBaseURI;
    uint256 public totalVotes;

    /* Structs */
    struct Donation {
        address donor;
        uint256 amount;
        uint256 timestamp;
    }

    struct Project {
        string description;
        uint256 voteCount;
    }

    /* Mappings and arrays */
    mapping(uint256 => Donation) public donations;
    Project[] public projects;

    /* Events */
    /**
     * @dev Emitted when a user makes a donation and receives an NFT.
     * @param donor The address of the donor.
     * @param tokenId The ID of the minted NFT.
     * @param amount The amount of Ether donated.
     * @param timestamp The timestamp of the donation.
     */
    event DonationEvent(address indexed donor, uint256 indexed tokenId, uint256 amount, uint256 timestamp);

    /**
     * @dev Emitted when an NFT owner votes on a charity project.
     * @param voter The address of the NFT owner casting the vote.
     * @param tokenId The ID of the NFT used for voting.
     * @param projectId The ID of the charity project being voted on.
     * @param timestamp The timestamp of the vote.
     */
    event VoteEvent(address indexed voter, uint256 indexed tokenId, uint256 indexed projectId, uint256 timestamp);

    /**
     * @dev Emitted when the contract owner adds a new charity project for voting.
     * @param description The description of the new charity project.
     * @param projectId The ID of the newly added project.
     * @param timestamp The timestamp of the project addition.
     */
    event ProjectAddedEvent(string description, uint256 indexed projectId, uint256 timestamp);

    /* Constructor to initialize the NFT with name, symbol, charity address, and base URI */
    constructor(
        string memory _name,
        string memory _symbol,
        address _charityAddress,
        string memory _baseURI
    ) ERC721(_name, _symbol) Ownable(msg.sender) {
        charityAddress = _charityAddress;
        tokenBaseURI = _baseURI;
    }

    /* Functions */
    /**
     * @dev Function to allow users to donate and receive an NFT.
     * @notice The donated amount must be greater than 0.
     * @return tokenId The ID of the minted NFT.
     */
    function donate() external payable returns (uint256 tokenId) {
        require(msg.value > 0, "Donation amount must be greater than 0");

        tokenId = tokenIdCounter;
        tokenIdCounter++;

        _mint(msg.sender, tokenId);

        donations[tokenId] = Donation(msg.sender, msg.value, block.timestamp);
        totalDonations += msg.value;

        emit DonationEvent(msg.sender, tokenId, msg.value, block.timestamp);
    }

    /**
     * @dev Function for NFT owners to vote on charity projects.
     * @param _tokenId The ID of the NFT used for voting.
     * @param _projectId The ID of the charity project being voted on.
     */
    function vote(uint256 _tokenId, uint256 _projectId) external {
        require(ownerOf(_tokenId) == msg.sender, "You do not own this NFT");
        require(_projectId < projects.length, "Invalid project ID");

        projects[_projectId].voteCount++;
        totalVotes++;

        emit VoteEvent(msg.sender, _tokenId, _projectId, block.timestamp);
    }

    /**
     * @dev Function to add a new project for voting.
     * @param _description The description of the new charity project.
     * @notice Only the contract owner can add new projects.
     */
    function addProject(string memory _description) external onlyOwner {
        projects.push(Project(_description, 0));

        uint256 projectId = projects.length - 1;
        emit ProjectAddedEvent(_description, projectId, block.timestamp);
    }

    /**
     * @dev Function to provide an impact report.
     * @return totalVotesRetrieved The total number of votes cast by NFT owners.
     * @return numberOfProjects The total number of charity projects available for voting.
     */
    function getImpactReport() external view returns (uint256 totalVotesRetrieved, uint256 numberOfProjects) {
        numberOfProjects = projects.length;
        totalVotesRetrieved = totalVotes;
    }
}
