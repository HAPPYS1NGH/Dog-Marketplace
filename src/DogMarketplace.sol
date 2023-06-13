//SPDX-License-Identifier: UNLICENSED
import "../lib/openzeppelin-contracts/contracts/utils/Counters.sol";
import {DogNFT} from "./DogNFT.sol";
import {Dog} from "./static/Structs.sol";

pragma solidity 0.8.19;

contract Marketplace {
    using Counters for Counters.Counter;

    Counters.Counter private _dogIdCounter;

    DogNFT dogNFT;

    mapping(uint256 => Dog) dogs;

    constructor() {
        dogNFT = new DogNFT();
    }

    function currentId() public view returns (uint256) {
        return _dogIdCounter.current();
    }

    function addDog(
        string calldata _name,
        string calldata _breed,
        uint256 _dob,
        address payable _owner,
        bool _availableForAdoption,
        string calldata _gender,
        uint256 _price
    ) public {
        _dogIdCounter.increment();
        uint256 newDogId = _dogIdCounter.current();

        dogs[newDogId] = Dog({
            id: newDogId,
            name: _name,
            breed: _breed,
            dob: _dob,
            owner: _owner,
            availableForAdoption: _availableForAdoption,
            gender: _gender,
            price: _price,
            verified: false
        });
    }

    function modifyDog(uint256 _id, bool _availableForAdoption, uint256 _price) public {
        require(dogs[_id].id != 0, "Dog with the given ID does not exist");
        require(dogs[_id].owner == msg.sender, "Only owner can modify");
        Dog storage dog = dogs[_id];
        dog.availableForAdoption = _availableForAdoption;
        if (_price != 0) {
            dog.price = _price;
        }
        dog.verified = false;
    }

    function transferDog(address payable newOwner, uint256 _id) public {
        require(dogs[_id].owner == msg.sender, "Only owner can modify");
        Dog storage dog = dogs[_id];
        dog.owner = newOwner;
    }

    function getDogById(uint256 _id) public view returns (Dog memory) {
        return dogs[_id];
    }

    function deleteDog(uint256 _id) public {
        require(dogs[_id].id != 0, "Dog with the given ID does not exist");
        require(dogs[_id].owner == msg.sender, "Only owner can delete");
        delete dogs[_id];
        // dogNFT.burn(_id);
    }

    function buyDog(uint256 _id) public payable {
        Dog storage dog = dogs[_id];
        require(msg.value >= dog.price);
        require(dog.availableForAdoption == true);
        dog.owner = payable(msg.sender);
        dog.availableForAdoption = false;
    }

    function mintDogNFT(uint256 _id, string memory _uri) public {
        require(dogs[_id].verified == true);
        dogNFT.safeMint(dogs[_id].owner, _id, _uri);
    }

    function verifyDog(uint256 _id) public {
        dogs[_id].verified = true;
    }
}
