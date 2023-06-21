// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.13;

// import "forge-std/Test.sol";
// import "forge-std/console.sol";
// import "../src/core/DogMarketplace.sol";
// import {Dog} from "../src/static/Structs.sol";

// contract MarketplaceTest is Test {
//     DogMarketplace public dogMarketplace;
//     address payable owner1 = payable(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
//     address payable owner2 = payable(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
//     address payable owner3 = payable(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
//     address payable owner4 = payable(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
//     address payable owner5 = payable(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);

//     function setUp() public {
//         dogMarketplace = new DogMarketplace();
//         uint256 initialId = dogMarketplace.currentId();
//         console.log(initialId);
//         assertEq(initialId, 0);
//         startHoax(owner1);
//     }

//     // use  --via-ir for testing
//     // function testDogFuzz(
//     //     string calldata _name,
//     //     string calldata _breed,
//     //     uint256 _dob,
//     //     address payable _owner,
//     //     bool _availableForAdoption,
//     //     string calldata _gender,
//     //     uint256 _price
//     // ) public {
//     //     dogMarketplace.addDog(_name, _breed, _dob, _owner, _availableForAdoption, _gender, _price);
//     //     uint256 newId = dogMarketplace.currentId();
//     //     assertEq(newId, 1);
//     //     (
//     //         uint256 did,
//     //         string memory dname,
//     //         string memory dbreed,
//     //         uint256 ddob,
//     //         address downer,
//     //         bool davailableForAdoption,
//     //         string memory dgender,
//     //         uint256 dprice
//     //     ) = getDogData(newId);

//     //     assertEq(did, 1);
//     //     assertEq(dname, _name);
//     //     assertEq(dbreed, _breed);
//     //     assertEq(ddob, _dob);
//     //     assertEq(downer, _owner);
//     //     assertEq(davailableForAdoption, _availableForAdoption);
//     //     assertEq(dgender, _gender);
//     //     assertEq(dprice, _price);
//     // }

//     function testAddDog() public {
//         dogMarketplace.addDog("Tuffy", "German Shepherd", 10032013, owner1, "Male", 0.01 ether, "Fuffy" ,"Muffy" , "golden" , "uri" );
//         uint256 newId = dogMarketplace.currentId();
//         assertEq(newId, 1);
//         assertEq("Tuffy", dogMarketplace.getDogById(newId).name);
//         assertEq("German Shepherd", dogMarketplace.getDogById(newId).breed);
//         assertEq(10032013, dogMarketplace.getDogById(newId).dob);
//         assertEq(owner1, dogMarketplace.getDogById(newId).owner);
//         assertEq(true, dogMarketplace.getDogById(newId).availableForAdoption);
//         assertEq("Male", dogMarketplace.getDogById(newId).gender);
//     }

//     function getDogDataStruct(uint256 _id) public view returns (Dog memory) {
//         return dogMarketplace.getDogById(_id);
//     }

//     function getDogData(uint256 _id)
//         public
//         view
//         returns (uint256, string memory, string memory, uint256, address, bool, string memory, uint256)
//     {
//         Dog memory dog1 = dogMarketplace.getDogById(_id);
//         console.log(dog1.id);
//         console.log(dog1.name);
//         console.log(dog1.breed);
//         console.log(dog1.dob);
//         console.log(dog1.owner);
//         console.log(dog1.availableForAdoption);
//         console.log(dog1.gender);
//         console.log(dog1.price);
//         return
//             (dog1.id, dog1.name, dog1.breed, dog1.dob, dog1.owner, dog1.availableForAdoption, dog1.gender, dog1.price);
//     }

//     function addDogs() public {
//         dogMarketplace.addDog("Tuffy", "German Shepherd", 10032013, owner1, true, "Male", 0.01 ether);
//     }

//     function testModifyDog() public {
//         addDogs();
//         dogMarketplace.modifyDog(1, false, 0.1 ether);
//         (,,,,, bool avail,, uint256 newPrice) = getDogData(1);
//         assertEq(avail, false);
//         assertEq(newPrice, 0.1 ether);
//     }

//     function testTransferDog() public {
//         addDogs();
//         dogMarketplace.transferDog(owner2, 1);
//         (,,,, address newOwner,,,) = getDogData(1);
//         assertEq(newOwner, owner2);
//         vm.stopPrank();
//         startHoax(owner2);
//         dogMarketplace.modifyDog(1, false, 0.1 ether);
//         (,,,,, bool avail,, uint256 newPrice) = getDogData(1);
//         assertEq(avail, false);
//         assertEq(newPrice, 0.1 ether);
//     }

//     function testDeleteDog() public {
//         addDogs();
//         dogMarketplace.deleteDog(1);
//         (uint256 did,,, uint256 ddob,,,, uint256 dprice) = getDogData(1);
//         assertEq(did, 0);
//         assertEq(ddob, 0);
//         assertEq(dprice, 0);
//     }
// }
