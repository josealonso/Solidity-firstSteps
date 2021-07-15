// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.3;

// Prior Solidity 0.6 the fallback function was simply an anonymous function that looked like this:
// function () external { }
// It's now two different functions: receive() to receive money and fallback() to just interact with 
// the Smart Contract without receiving Ether. 

contract FallbackFunctionsExample {
    mapping(address => uint) public balanceReceived;

    address payable public owner;

    // The constructor is executed only during deployment. There is no way to execute the constructor code afterwards.
    constructor() {
        owner = payable(msg.sender);
    }

    function destroySmartContract() public {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(owner);
    }

    function receiveMoney() public payable {
        assert(balanceReceived[msg.sender] + msg.value >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        require(_amount <= balanceReceived[msg.sender], "Not enough funds");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    receive() external payable {
        receiveMoney();
    }

}
