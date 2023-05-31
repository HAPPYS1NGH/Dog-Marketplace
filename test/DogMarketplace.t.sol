// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/DogMarketplace.sol";

contract CounterTest is Test {
    Marketplace public dogMarketplace;
    address owner1 = address(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
    address owner2 = address(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
    address owner3 = address(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
    address owner4 = address(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
    address owner5 = address(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);

    struct Dog {
        uint256 id;
        string name;
        string breed;
        uint256 dob;
        address owner;
        bool availableForAdoption;
        string gender;
    }

    function setUp() public {
        dogMarketplace = new Marketplace();
        uint256 initialId = dogMarketplace.currentId();
        console.log(initialId);
        assertEq(initialId, 0);
    }

    function testAddDog(
        string calldata _name,
        string calldata _breed,
        uint256 _dob,
        address _owner,
        bool _availableForAdoption,
        string calldata _gender
    ) public {
        startHoax(owner1);
        dogMarketplace.addDog(_name, _breed, _dob, _owner, _availableForAdoption, _gender);
        uint256 newId = dogMarketplace.currentId();
        assertEq(newId, 1);
        (
            uint256 did,
            string memory dname,
            string memory dbreed,
            uint256 ddob,
            address downer,
            bool davailableForAdoption,
            string memory dgender
        ) = getDogData(newId);

        assertEq(did, 1);
        // assertEq(dname, _name);
        // assertEq(dbreed, _breed);
        assertEq(ddob, _dob);
        assertEq(downer, _owner);
        assertEq(davailableForAdoption, _availableForAdoption);
        assertEq(dgender, _gender);
    }

    function getDogData(uint256 _id)
        public
        view
        returns (uint256, string memory, string memory, uint256, address, bool, string memory)
    {
        Dog memory dog1 = Dog(
            dogMarketplace.getDogById(_id).id,
            dogMarketplace.getDogById(_id).name,
            dogMarketplace.getDogById(_id).breed,
            dogMarketplace.getDogById(_id).dob,
            dogMarketplace.getDogById(_id).owner,
            dogMarketplace.getDogById(_id).availableForAdoption,
            dogMarketplace.getDogById(_id).gender
        );
        // console.log(dog1.id);
        // console.log(dog1.name);
        // console.log(dog1.breed);
        // console.log(dog1.dob);
        // console.log(dog1.owner);
        // console.log(dog1.availableForAdoption);
        // console.log(dog1.gender);
        return (dog1.id, dog1.name, dog1.breed, dog1.dob, dog1.owner, dog1.availableForAdoption, dog1.gender);
    }

    // function testSetNumber(uint256 x) public {
    //     counter.setNumber(x);
    //     assertEq(counter.number(), x);
    // }
}
