//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "openzeppelin/contracts/utils/Counters.sol";
import {DogNFT} from "../utils/DogNFT.sol";
import {Dog} from "../static/Structs.sol";

/// @title DogMarketplace
/// @author Harpreet Singh
/// @notice You can use this contract for minting Dog NFTs and selling them

contract DogMarketplace {
    ///////////////////////////////
    //// Errors ///////////////////
    ///////////////////////////////

    error DogAlreadyExists();
    error InvalidDOB(uint256 dob);
    error InvalidPrice(uint256 price);
    error OnlyOwner(address given, address owner);
    error InvalidAddress(address given);
    error NotEnoughFundsSent(uint256 valueSent, uint256 priceOfDog);

    ///////////////////////////////
    //// Libraries & Contracts ////
    ///////////////////////////////

    using Counters for Counters.Counter;

    DogNFT public dogNFT;

    ///////////////////////////////

    ///////////////////////////////
    //// State Variables //////////
    ///////////////////////////////

    Counters.Counter private _dogIdCounter;
    mapping(string => Dog) dogs;

    ///////////////////////////////
    //// Events ///////////////////
    ///////////////////////////////

    event DogRegistered(
        uint256 id,
        string name,
        string breed,
        uint256 dob,
        address owner,
        string gender,
        uint256 price,
        string fatherName,
        string motherName,
        string colour,
        string uri
    );

    event DogTransfered(uint256 id, string name, address previousOwner, address newOwner);

    event DogModified(uint256 id, string name, uint256 price);

    event DogDeleted(uint256 id, string name);

    event DogPurchased(uint256 id, string name, address previousOwner, address newOwner, uint256 price);

    ///////////////////////////////
    //// Modifiers ////////////////
    ///////////////////////////////

    modifier onlyOwner(address _owner) {
        if (msg.sender != _owner) {
            revert OnlyOwner(_owner, msg.sender);
        }
        _;
    }

    ///////////////////////////////
    //// Functions ////////////////
    ///////////////////////////////

    ///////////////////////////////
    //// Constructor //////////////
    ///////////////////////////////
    constructor() {
        dogNFT = new DogNFT();
    }

    ///////////////////////////////
    //// External Functions ///////
    ///////////////////////////////

    function addDog(
        string calldata _name,
        string calldata _breed,
        uint256 _dob,
        address payable _owner,
        bool _availableForAdoption,
        string calldata _gender,
        uint256 _price,
        string calldata _fatherName,
        string calldata _motherName,
        string calldata _colour,
        string calldata _uri
    ) external {
        if (dogs[_name].owner != address(0)) {
            revert DogAlreadyExists();
        }
        if (_dob > block.timestamp) {
            revert InvalidDOB(_dob);
        }
        if (_price == 0) {
            revert InvalidPrice(_price);
        }
        _dogIdCounter.increment();
        uint256 newDogId = _dogIdCounter.current();

        dogs[_name] = Dog({
            id: newDogId,
            name: _name,
            breed: _breed,
            dob: _dob,
            owner: _owner,
            gender: _gender,
            price: _price,
            fatherName: _fatherName,
            motherName: _motherName,
            colour: _colour
        });
        dogNFT.safeMint(msg.sender, _uri);

        emit DogRegistered(
            newDogId, _name, _breed, _dob, _owner, _gender, _price, _fatherName, _motherName, _colour, _uri
        );
    }

    function modifyDogPrice(string calldata _name, uint256 _price) external onlyOwner(dogs[_name].owner) {
        Dog storage dog = dogs[_name];
        if (_price == 0) {
            revert InvalidPrice(_price);
        }
        dog.price = _price;
        emit DogModified(dog.id, dog.name, dog.price);
    }

    function buyDog(string calldata _name) external payable {
        Dog storage dog = dogs[_name];
        if (msg.value < dog.price) {
            revert NotEnoughFundsSent(msg.value, dog.price);
        }
        address payable previousOwner = dog.owner;
        dog.owner = payable(msg.sender);
        emit DogPurchased(dog.id, dog.name, previousOwner, msg.sender, dog.price);
    }

    function transferDog(address payable newOwner, string calldata _name) external onlyOwner(dogs[_name].owner) {
        Dog storage dog = dogs[_name];
        if (newOwner == address(0)) {
            revert InvalidAddress(newOwner);
        }
        address payable previousOwner = dog.owner;
        dog.owner = newOwner;
        emit DogTransfered(dog.id, dog.name, previousOwner, newOwner);
    }

    function deleteDog(string calldata _name) public onlyOwner(dogs[_name].owner) {
        Dog memory dog = dogs[_name];
        delete dogs[_name];
        emit DogDeleted(dog.id, dog.name);
    }

    ///////////////////////////////
    //// Public View Functions ////
    ///////////////////////////////

    function getDogByName(string calldata _name) public view returns (Dog memory) {
        return dogs[_name];
    }

    function getDogURIByName(string calldata _name) public view returns (string memory) {
        return dogNFT.tokenURI(dogs[_name].id);
    }

    function currentId() public view returns (uint256) {
        return _dogIdCounter.current();
    }
}
