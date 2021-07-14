// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

contract MappingStructExample {
    mapping(address => uint256) public balanceReceived;

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function sendMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint256 _amount) public {
        require(balanceReceived[msg.sender] >= _amount, "Not enough funds");
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    function withdrawAllMoney(address payable _to) public {
        uint256 balanceToSend = balanceReceived[msg.sender];
        balanceReceived[msg.sender] = 0;
        _to.transfer(balanceToSend);
    }
}
