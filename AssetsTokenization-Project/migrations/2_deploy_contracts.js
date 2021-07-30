var MyToken = artifacts.require("./MyToken.sol");
var MyTokenSale = artifacts.require("./MyTokenSale");

module.exports = async function(deployer) {
  let addr = await web3.eth.getAccounts();
  await deployer.deploy(MyToken, 10000);
  // transfer all the tokens from the msg sender to the MyTokenSales smart contract 
  await deployer.deploy(MyTokenSale, 1, addr[0], MyToken.address);
  let instance = await MyToken.deployed();
  await instance.transfer(MyTokenSale.address, 10000);
};
