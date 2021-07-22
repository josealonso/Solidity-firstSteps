// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.2.0/contracts/access/Ownable.sol";

contract Allowance is Ownable {

    mapping(address => uint256) public allowance;

    function addAllowance(address _who, uint256 _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    modifier ownerOrAllowed(uint256 _amount) {
        require(
            owner() == msg.sender || allowance[msg.sender] >= _amount,
            "You are not allowed."
        );
        _;
    }

    function reduceAllowance(address _who, uint256 _amount) internal {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who] - _amount);
        allowance[_who] = allowance[_who] - _amount;
    }
}

// This is the contract that must be deployed
contract SimpleWallet is Allowance {

    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);
    
    function withdrawMoney(address payable _to, uint256 _amount)
        public
        ownerOrAllowed(_amount)
    {
        require(
            _amount <= address(this).balance,
            "There are not enough funds stored in the smart contact"
        );
        // Structure to avoid double spending
        if (owner() != msg.sender) {
            reduceAllowance(_to, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }

    function renounceOwnership() public pure override {
        revert("Can't renounce ownership here");
    }
    
    receive() external payable {  // deposit money into the SC
        emit MoneyReceived(msg.sender, msg.value);
    }
}
