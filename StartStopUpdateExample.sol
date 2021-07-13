// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

contract StartStopUpdateExample {
    address public owner;

    bool public paused;

    constructor() {
        owner = msg.sender;
    }

    function sendMoney() public payable {}

    function setPaused(bool _paused) public {
        require(msg.sender == owner, "You are not the owner");
        paused = _paused;
    }

    function withdrawAllMoney(address payable _to) public {
        require(msg.sender == owner, "You are not the owner");
        require(!paused, "Contract is paused");
        _to.transfer(address(this).balance);
    }

    // There might be an Ethereum Protocol update coming ahead which removes the SELFDESTRUCT functionality all-together. As of July 2021, it's not out there (yet)
    // With the CREATE2 op-code you can instruct the EVM to place your Smart Contract on a specific address
    function destroySmartContract(address payable _to) public {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(_to);
    }
}
