// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.2.0/contracts/access/Ownable.sol";

contract Allowance is Ownable {
    
    mapping(address => uint) public allowance;

    function addAllowance(address _who, uint _amount) public onlyOwner {
        allowance[_who] = _amount;
    }    

    modifier ownerOrAllowed(uint _amount) {
        require(owner() == msg.sender || allowance[msg.sender] >= _amount, "You are not allowed.");
        _;
    }

    function reduceAllowance(address _who, uint _amount) internal {
        allowance[_who] = allowance[_who] - _amount; 
    }
    
}

// Thi is the contract that must be deployed
contract SimpleWallet is Allowance {

/*
    mapping(address => uint) public allowance;

    function addAllowance(address _who, uint _amount) public onlyOwner {
        allowance[_who] = _amount;
    }    
    
    modifier ownerOrAllowed(uint _amount) {
        require(owner() == msg.sender || allowance[msg.sender] >= _amount, "You are not allowed.");
        _;
    }
    
    function reduceAllowance(address _who, uint _amount) internal {
        // require(_amount <= allowance[_who], "");
        allowance[_who] = allowance[_who] - _amount; 
    }    */
    
    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {  
        require(_amount <= address(this).balance, "There are not enough funds stored in the smart contact");         
        // Structure to avoid double spending
        if (owner() != msg.sender) {
            reduceAllowance(_to, _amount);
        }
        _to.transfer(_amount);
        
    }
    
    receive() external payable {    // deposit money into the SC
        
    }
}    
