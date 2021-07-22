// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.5.11;

// ======================================================
// First solution. Tested on Remix.    
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract SimpleWallet {
    
    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(owner == msg.owner, "You are not allowed");
        _;
    }

    function withdrawMoney(address payable _to, uint _amount) public onlyOwner {  
        _to.transfer(_amount);
    }
    
    receive() external payable {    // deposit money into the SC
        
    }
}    

// Next version: using OpenZeppelin contracts

// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.2.0/contracts/access/Ownable.sol";

contract SimpleWallet is Ownable {

    function withdrawMoney(address payable _to, uint _amount) public onlyOwner {  
        _to.transfer(_amount);
    }
    
    receive() external payable {    // deposit money into the SC
        
    }
}    
