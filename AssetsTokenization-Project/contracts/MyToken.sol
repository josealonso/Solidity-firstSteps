// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Added ERC20 OpenZeppelin contract, version 4.x

contract MyToken is ERC20 {
    constructor(uint256 initialSupply) public ERC20("Complutum Token", "CPL") {
        _mint(msg.sender, initialSupply);
    }

    function decimals() public view override returns (uint8) {
        return 0; // By default, ERC20 uses a value of 18 for decimals
    }
    /* It is important to understand that decimals is only used for display purposes. 
     All arithmetic inside the contract is still performed on integers, 
     and it is the different user interfaces (wallets, exchanges, etc.) that must adjust the displayed values according to decimals */
}
