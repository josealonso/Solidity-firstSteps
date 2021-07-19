//SPDX-License-Idenfitier: MIT
pragma solidity ^0.5.11;

// If the smart contract is deployed in the Javascript VM, it works.
// But it doesn't work on real blockchains ("Injected Web3" option on Remix), since the output is empty.

contract EventExample {
    
    mapping(address => uint) public tokenBalance;

    constructor() public {
        tokenBalance[msg.sender] = 100;
    }

    function sendToken(address _to, uint _amount) public returns(bool) {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;

        return true;
    }

}
