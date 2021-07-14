//SPDX-License-Idenfitier: MIT
pragma solidity 0.8.4;

// There is a new concept in Solidity since Solidity 0.6, which allows for basic try/catch inside a Smart Contract. 
// Before that you had to use constructs like "address.call".
// The second contract will catch the error, and instead of unsuccessfully showing an error, 
// it will successfully mine the transaction. During the transaction it will emit an event that shows the error message. 
// This message can be seen later in the transaction logs.

contract WillThrow {
    function aFunction() public {
        require(false, "Error message");
    }
}

contract ErrorHandling {
    event ErrorLogging(string reason);
    function catchError() public {
        WillThrow will = new WillThrow();
        try will.aFunction() {
            //here we could do something if it works
        }  catch Error(string memory reason) {
            emit ErrorLogging(reason);
        }
    }
}
