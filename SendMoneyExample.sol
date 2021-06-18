pragma solidity ^0.8.1;

contract SendMoneyExample {

uint public balanceReceived;

    function receiveMoney() public payable {
        
    }

    // 1 eth = 10^18 wei
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function withdrawMoney() public {
        address payable to = msg.sender;
        to.transfer(this.getBalance());
    } // The payable modifier allows to receive money

    function withdrawMoneyTo(address payable _to) public {
        _to.transfer(this.getBalance());
    }
}


