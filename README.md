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
