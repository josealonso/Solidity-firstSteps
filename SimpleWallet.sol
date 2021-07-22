// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./Allowance.sol";

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
