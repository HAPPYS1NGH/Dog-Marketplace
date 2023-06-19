// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/utils/DogNFT.sol";
import {Dog} from "../src/static/Structs.sol";

contract NFTTest is Test, DogNFT {
    address payable owner1 = payable(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
    address payable owner2 = payable(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
    address payable owner3 = payable(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
    address payable owner4 = payable(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
    address payable owner5 = payable(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);

    function setUp() public {
        startHoax(owner1);
    }
}
