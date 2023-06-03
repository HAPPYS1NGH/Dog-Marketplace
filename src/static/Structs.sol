// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

struct Dog {
        uint256 id;
        string name;
        string breed;
        uint256 dob;
        address payable owner;
        bool availableForAdoption;
        string gender;
        uint256 price;
        bool verified;
    }