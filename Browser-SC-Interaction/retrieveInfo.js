// import { eth, utils } from "web3";
const nodeUrl = "http://localhost:7545";
const web3 = require("web3");
let web3 = new Web3(new Web3.providers.HttpProvider(nodeUrl));
let account = "0x..........";
let otherAccount = "0x..........";
eth.getBalance(account).then(function (result) {
    console.log('Amount in  Ethers: ' + utils.fromWei(result, 'ether'));
});
// Send Ether from one account to another one
eth.sendTransaction({
    from: account, to: otherAccount, value: Web3.utils.toWei("2", "ether")
});

// Open index.html and type this on the developer console: 
/* let myContract = new web3.eth.Contract(
    [
      {
          "constant": false,
          "inputs": [
              {
                  "internalType": "uint256",
                  "name": "_myUint",
                  "type": "uint256"
              }
          ],
          "name": "setUint",
          "outputs": [],
          "payable": false,
          "stateMutability": "nonpayable",
          "type": "function"
      },
      {
          "constant": true,
          "inputs": [],
          "name": "myUint",
          "outputs": [
              {
                  "internalType": "uint256",
                  "name": "",
                  "type": "uint256"
              }
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
      }
  ], "0xecBc05a5a3869F5ccd64A68157128591A47e47B2"); */

  /*
  First parameter: ABI array.
  Second parameter: contract address.
  Both have been taken from Remix.
  */