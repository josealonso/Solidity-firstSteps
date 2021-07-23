pragma solidity ^0.6.0;

import "./Item.sol";

// Improvement: the user can be given a simple address to send money to

contract ItemManager {

    enum SupplyChainState{Created, Paid, Delivered}

    struct S_Item {
        Item _item;
        ItemManager.SupplyChainState _step;
        string _identifier;
    }
    
    mapping(uint => S_Item) public items;
    uint itemIndex;

    event SupplyChainStep(uint _itemIndex, uint _step, address _itemAddress);

    function createItem(string memory _identifier, uint _itemPrice) public {
        // "this" refers to the current contract
        Item item = new Item(this, _itemPrice, itemIndex);
        items[itemIndex]._item = item;
        items[itemIndex]._step = SupplyChainState.Created;
        items[itemIndex]._identifier = _identifier;
        emit SupplyChainStep(itemIndex, uint(items[itemIndex]._step), address(item));
        itemIndex++;
    }
    
    function triggerPayment(uint _index) public payable {
        Item item = items[_index]._item;
        require(address(item) == msg.sender, "Only items are allowed to update themselves");
        require(item.priceInWei() == msg.value, "Not fully paid yet");
        require(items[_index]._step == SupplyChainState.Created, "Item is further in the supply chain");
        items[_index]._step = SupplyChainState.Paid;
        
        emit SupplyChainStep(_index, uint(items[_index]._step), address(items[_index]._item));
    }
    
    function triggerDelivery(uint _index) public {
        require(items[_index]._step == SupplyChainState.Paid, "Item is further in the supply chain");
        items[_index]._step == SupplyChainState.Delivered;
        
        emit SupplyChainStep(_index, uint(items[_index]._step), address(items[_index]._item));        
    }
    
}
