//SPDX-License-Idenfitier: MIT
pragma solidity ^0.5.11;

// If the smart contract is deployed in the Javascript VM, it works.
// But it doesn't work on real blockchains ("Injected Web3" option on Remix), since the output is empty.
// Return values are meant for inter-smart-contract communication, they won’t return anything to the
// transaction origin. 
// SOLUTION ---> using Events for outputting anything in writing transactions.

contract EventExample {
    
    mapping(address => uint) public tokenBalance;

    event TokensSent(address _from, address _to, uint _amount);

    constructor() public {
        tokenBalance[msg.sender] = 100;
    }

    function sendToken(address _to, uint _amount) public returns(bool) {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;

        emit TokensSent(msg.sender, _to, _amount);

        return true;
    }

}
