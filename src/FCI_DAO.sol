// SPDX-License-Identifier: UNLICENSED
import "./utils/FCI_RoleManagement.sol";
import "./utils/FCI_Token.sol";
import "openzeppelin/contracts/access/Ownable.sol";

pragma solidity ^0.8.13;

contract FCI_DAO {
    enum Roles {
        MEMBER,
        ADVISOR,
        VERIFIER
    }

    mapping(address => Roles) role;
}
