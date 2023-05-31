//SPDX-License-Identifier: UNLICENSED
import "openzeppelin/contracts/utils/Counters.sol";

pragma solidity 0.8.19;

contract Marketplace {
    using Counters for Counters.Counter;

    Counters.Counter private _dogIdCounter;

    struct Dog {
        uint256 id;
        string name;
        string breed;
        uint256 dob;
        address owner;
        bool availableForAdoption;
        string gender;
    }

    mapping(uint256 => Dog) dogs;

    function currentId() public view returns (uint256) {
        return _dogIdCounter.current();
    }

    function addDog(
        string calldata _name,
        string calldata _breed,
        uint256 _dob,
        address _owner,
        bool _availableForAdoption,
        string calldata _gender
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
            gender: _gender
        });
    }

    function modifyDog(uint256 _id, bool _availableForAdoption) public {
        require(dogs[_id].id != 0, "Dog with the given ID does not exist");
        require(dogs[_id].owner != msg.sender, "Only owner can modify");
        Dog storage dog = dogs[_id];
        dog.availableForAdoption = _availableForAdoption;
    }

    function transferDog(address newOwner, uint256 _id) public {
        require(dogs[_id].owner != msg.sender, "Only owner can modify");
        Dog storage dog = dogs[_id];
        dog.owner = newOwner;
    }

    function getDogById(uint256 _id) public view returns (Dog memory) {
        return dogs[_id];
    }

    function deleteDog(uint256 _id) public {
        require(dogs[_id].id != 0, "Dog with the given ID does not exist");
        require(dogs[_id].owner != msg.sender, "Only owner can delete");
        delete dogs[_id];
    }
}
