// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.5.13;

// Libraries are stateless.
// They make your contracts safer.
// They aren't used to upgrade the contract.
// OpenZeppelin has many audited libraries.

import "https://github.com/OpenZeppelin/openzeppelin-
contracts/contracts/math/SafeMath.sol";

contract LibrariesExample {
    using SafeMath for uint;

    mapping(address => uint) public tokenBalance;

    constructor() public {
        tokenBalance[msg.sender] = tokenBalance[msg.sender].add(1);
    }

    function sendToken(address _to, uint _amount) public returns (bool) {

        tokenBalance[msg.sender] = tokenBalance[msg.sender].sub(_amount);
        tokenBalance[_to] = tokenBalance[msg.sender].add(_amount);    

        return true;
    }

}
