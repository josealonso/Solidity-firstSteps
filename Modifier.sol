// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.5.11;

// This line allows to put the Owned contract in a separate file.
import "./Owned.sol";

/* contract Owned {

    address owner; 

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not allowed");
        _;
    }
} */

contract ModifierExample is Owned {

    mapping(address => uint) public tokenBalance;
    
    uint tokenPrice = 1 ether;

    constructor() public {
        tokenBalance[owner] = 100;
    }

    function createNewToken() public onlyOwner {
        tokenBalance[owner]++;    
    }    
    // ......................
    // ......................
    // ......................

}
    