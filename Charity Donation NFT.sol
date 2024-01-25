// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

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

    event DonationEvent(address indexed donor, uint256 indexed tokenId, uint256 amount, uint256 timestamp);
    event VoteEvent(address indexed voter, uint256 indexed tokenId, uint256 indexed projectId, uint256 timestamp);
    event ProjectAddedEvent(string description, uint256 indexed projectId, uint256 timestamp);

    constructor(
        string memory _name,
        string memory _symbol,
        address _charityAddress,
        string memory _baseURI
    ) ERC721(_name, _symbol) Ownable(msg.sender) {
        require(bytes(_name).length > 0 && bytes(_name).length <= 50, "Invalid name length");
        require(bytes(_symbol).length > 0 && bytes(_symbol).length <= 10, "Invalid symbol length");
        require(_charityAddress != address(0), "Invalid charity address");
        require(bytes(_baseURI).length > 0, "Invalid base URI");

        charityAddress = _charityAddress;
        tokenBaseURI = _baseURI;
    }

    function donate() external payable returns (uint256 tokenId) {
        require(msg.value > 0, "Donation amount must be greater than 0");

        tokenId = tokenIdCounter;
        tokenIdCounter++;

        _mint(msg.sender, tokenId);

        donations[tokenId] = Donation(msg.sender, msg.value, block.timestamp);
        totalDonations += msg.value;

        emit DonationEvent(msg.sender, tokenId, msg.value, block.timestamp);
    }

    function vote(uint256 _tokenId, uint256 _projectId) external {
        require(ownerOf(_tokenId) == msg.sender, "You do not own this NFT");
        require(_projectId < projects.length, "Invalid project ID");

        Project storage selectedProject = projects[_projectId];
        selectedProject.voteCount++;
        totalVotes++;

        emit VoteEvent(msg.sender, _tokenId, _projectId, block.timestamp);
    }

    function addProject(string memory _description) external onlyOwner {
        require(bytes(_description).length > 0, "Project description cannot be empty");
        require(bytes(_description).length <= 100, "Project description is too long");
        require(projects.length < 100, "Exceeded maximum number of projects");

        projects.push(Project(_description, 0));

        uint256 projectId = projects.length - 1;
        emit ProjectAddedEvent(_description, projectId, block.timestamp);
    }

    function getImpactReport() external view returns (uint256 totalVotesRetrieved, uint256 numberOfProjects) {
        numberOfProjects = projects.length;
        totalVotesRetrieved = totalVotes;
    }
}
