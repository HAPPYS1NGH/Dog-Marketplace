// SPDX-License-Identifier: UNLICENSED
import "./utils/FCI_RoleManagement.sol";
import "./utils/FCI_Token.sol";

pragma solidity ^0.8.13;

contract FCI_DAO {
    uint256 public number;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
