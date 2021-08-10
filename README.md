# Solidity-firstSteps

## Variables

There is no null or undefined
(U)Int = 0
Bool = false
String = ""

For memory location ---> modifiers memory and storage

Uint8 to Uint256 in  8 bit increments
uint is an alias for uint256

Fixed Point Numbers ---> they don't exist

Address and address Payable

Strings

String is a byte array, but doesn't have a length or index-access.
They are expensive

Limited resources
Variable initialization
A public variable automatically creates a getter function in solidity


## Mappings

- All values are initialized by default.
- Mappings don't have a "length".
- Iterable mappings can be implemented using libraries.

## Structs

- Syntax similar to structs in C language.
- Allow to define your own data type.
- For gas cunsumption ---> It's better to define structs than objects.
- Mapping and structs are a powerful combination.

## Arrays

- Fixed or dynamic size.
- More intuitive (length, push), but mappings are more used because of the gas consumption.

## Enums

- Will be integers internally.
- Up to 256 values ----> uint8 is used
- More than 256 values ----> uint16 is used

## Re-Entrancy and Checks-Effects-Interaction Pattern

As a rule of thumb: You interact with outside addresses last, no matter what. Unless you have a trusted source. So, first set your Variables to the state you want, as if someone could call back to the Smart Contract before you can execute the next line after .transfer(...). Read more about this here: https://fravoll.github.io/solidity-patterns/checks_effects_interactions.html


## Exceptions 

- Transactions are atomic operations <---> Errors revert the state.
- There's no catching mechanism in Solidity.
- Keywords: require, assert, revert. "throw" was used in old versions, removed in Solidity 0.4.10.
require -------> validate user input. If it evaluates to false, it will throw an exception. 
assert --------> validate internal states (invariants)
revert --------> equivalent to require.


## Events

They admit up to three parameters.
Three use cases:
- Return values after a transaction is mined.
- Trigger
- Storage means, if data is not needed by the smart contract.

- Events are inheritable members.
- Events are cheap.


## ABI array

- It's a JSON file, containing all the functions, parameters and return values of the contact.
- The EVM codes result from encoding all the values in the last point. They are similar to assembly language codes.
- Gas costs are determined by the operational complexity.
Gas is detached from Ether.


## Solidity 0.6.0 Breaking Changes

- Virtual and override are new keywords.
If a function is going to be overriden ---> Mark it with `virtual`.
When defining a function already existing in other contract ---> Mark it with `override`.
- In order to prevent collisions by gigantic storage arrays, `length` cannot be used to modify the length of an array.
- State variable shadowing is now disallowed.

This won't compile if the private keyword is removed:
```
contract A {
    uint private x = 123;
}

contract B is A {
    uint x = 234;
}

```

- Fallback and Receive are separated functions.
- A try/catch statement 

## Browser-Smart Contract interaction

Library used: **web3js** 
An alternative is **etherjs**

## Connect Metamask

- It must be connected to **Localhost 8545**, which is the url used by truffle.
- Metamask ----> Nonce is the number of transactions sent from a given address. It's incremented once per transaction. But we're starting the truffle development network, which is our Ethereum blockchain. This results in strange errors.  
- Solution: go to advanced settings ---> **Reset Account**
- Solution to the "insufficient funds" message --->
In the Terminal where Truffle Developer Console is running scroll to the private keys on top. Copy the private key and add it into MetaMask. 
Click on "Import Account" and paste the private key on the text box. 
Then your new Account should appear here with ~100 Ether in it.

When running Ganache and truffle, we can send 2 ethers from the first Ganache account to the Metamask account doing this:

```
truffle console
truffle(ganache)> web3.eth.sendTransaction({to:"PASTE_ACCOUNT_FROM_METAMASK", from:accounts[0], value:web3.utils.toWei("2", "ether")});
```

## Use the KycContract using MetaMask

We could use another account in MetaMask to whitelist it.

- Copy one of your accounts in MetaMask (other than your account#1) to whitelist.
- Paste this account into the account-field in your new HTML UI.
- But before sending off the transaction, make sure you switch back to Account #1 (the account that created the smart contract from truffle migrate).
- You should see a popup to confirm the transaction and then an alert box, that tells you that your account is now whitelisted.
**IMPORTANT** This transaction will be confirmed only if the Metamask transaction history is reset.
- Account #2 is now whitelisted. But how to purchase Tokens?

## Buy Complu Tokens

To actually purchase any tokens, we must first get some ether into the account. Every token has a price, so, let's first send Ether from Account #1 to Account #2 by using Metamask.
Then simply send 1 Wei from your account. Initially, we set 1 Wei equals 1 Token, we might want to change that later on, but for testing it's okay. 
1 Ether = 10^18 Wei, so 1 Wei = 0.000000000000000001 Ether. 
In order to display the tokens within Metamask, we need to open MetaMask and add a custom Token to our UI.
You need the Token-Address, not the TokenSaleAddress. You can either print the address to the UI or copy it directly from the json file in the client/contracts/MyToken.json file.
Add in the Token-Address from the Token and the Symbol "CMP", then click next. You should see you token appear in MetaMask for your account.


## Use Truffle HDWallet Provider

npm i --save @truffle/hdwallet-provider

# Assets Tokenization Project

```
npm install -g truffle
truffle unbox react

npm install --save @openzeppelin/contracts@v3.0.0 (Solidity 0.6.0)

```

## Setting up and deployment


- Start the private blockchain

```
ganache-cli --networkId 1337 --chainId 1337
```

- Deploy the three smart contrats

```
truffle developer
truffle(develop)> migrate
```

or

```
truffle migrate
```

- Deploy the React server

```
cd client
npm run start
```


## Testing

```
npm i --save chai chai-bn chai-as-promised
truffle test
```
  or

```
truffle developer
truffle(develop)> test
```

## Deployment in a public network

Instead of the Ganache private blockchain node or a full node, like go_ethereum (geth), a Infura hosted blockchain node will be used.

- Create a new Infura project.

- Add the public networks to the truffle configuration file
```
 rinkeby_infura: {
      provider: function() {
        return new HDWalletProvider(process.env.MNEMONIC, "https://rinkeby.infura.io/v3/YOUR_INFURA_ID", MetaMaskAccountIndex)
      },
      network_id: 3
    },
```
Similar lines for the other test networks.

- Deployment command

```
truffle migrate --network rinkeby_infura
```