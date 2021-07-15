// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.3;

// Modifying state variables implies sending a transaction.
// Reading values, on the other hand, is virtually free and doesn't require mining.
// There are two types of reading functions:
//     view: Accessing state variables
//     pure: Not accessing state variables

contract FallbackFunctionsExample {
    mapping(address => uint256) public balanceReceived;

    address payable owner; // Thi is private now

    constructor() {
        owner = payable(msg.sender);
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function convertWeiToEth(uint256 _amount) public pure returns (uint) {
        return _amount / 1 ether;
    }

    function destroySmartContract() public {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(owner);
    }

    function receiveMoney() public payable {
        assert(
            balanceReceived[msg.sender] + msg.value >=
                balanceReceived[msg.sender]
        );
        balanceReceived[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint256 _amount) public {
        require(_amount <= balanceReceived[msg.sender], "Not enough funds");
        assert(
            balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount
        );
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    receive() external payable {
        receiveMoney();
    }
}
