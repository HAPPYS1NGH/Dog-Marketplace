// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FCI_Token is ERC20 {
    constructor() ERC20("FCI-DAO", "FCI") {}
}
