pragma solidity ^0.6.0;

import "./ItemManager.sol";

// This new contract is going to be responsible for taking the payment and
// handing the payment back to the item manager.
// So the actual payment happens in this contract.

contract Item {
    uint public priceInWei;
    uint public pricePaid;
    uint public index;
    
    ItemManager parentContract;
    
    constructor(ItemManager _parentContract, uint _priceInWei, uint _index) public {
        priceInWei = _priceInWei;        
        index = _index;
        parentContract = _parentContract;
    }
    
    receive() external payable {
        require(pricePaid == 0, "Item is paid already");
        require(priceInWei == msg.value, "Only full payments allowed");
        pricePaid += msg.value;
        // address(parentContract).transfer(msg.value);

        // In order to call the triggerPayment function, more gas is needed --->
        // A low-level function must be used ---> call.value

        // Solidity version 6.4 ---->
        // Using ".value(...)" is deprecated. Use "{value: ...}" instead.
        (bool success, ) = address(parentContract).call.value(msg.value)(abi.encodeWithSignature("triggerPayment(uint256)", index));
        /* (bool success, ) = address(parentContract).call
            {
                value: msg.value
            }(abi.encodeWithSignature("triggerPayment(uint256)", index)); */
        require(success, "Delivery did not work");
    }
    
    fallback() external { }  // This is for Remix to generate a button
}
