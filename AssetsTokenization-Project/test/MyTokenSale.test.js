const TokenSale = artifacts.require("MyTokenSale");
const Token = artifacts.require("MyToken");

const chai = require("./setupchai.js");
const BN = web3.utils.BN;
const expect = chai.expect;

require('dotenv').config({path: '../.env'});

contract("TokenSale Test", async accounts => {
    const [initialHolder, recipient, anotherAccount] = accounts;

    it("should not have any tokens in my deployerAccount", async () => {
        let instance = await Token.deployed();
        // let instance = this.myToken;
        // let totalSupply = await instance.totalSupply();
        // expect(await instance.balanceOf(accounts[0])).to.be.a.bignumber.equal(totalSupply);
        return expect(instance.balanceOf(initialHolder)).to.eventually.be.a.bignumber.equal(new BN(0));
    })

    // it("I can send tokens from Account 1 to Account 2", async () => {
    //     const sendTokens = 1;
    //     let instance = this.myToken;
    //     // let instance = await Token.deployed();
    //     let totalSupply = await instance.totalSupply();
    //     await expect(instance.balanceOf(initialHolder)).to.eventually.be.a.bignumber.equal(totalSupply);
    //     await expect(instance.transfer(recipient, sendTokens)).to.eventually.be.fulfilled;
    //     await expect(instance.balanceOf(initialHolder)).to.eventually.be.a.bignumber.equal(totalSupply.sub(new BN(sendTokens)));
    //     await expect(instance.balanceOf(recipient)).to.eventually.be.a.bignumber.equal(new BN(sendTokens));
    // });

    // it("It's not possible to send more tokens than account 1 has", async () => {
    //     let instance = this.myToken;
    //     // let instance = await Token.deployed();
    //     let balanceOfAccount = await instance.balanceOf(initialHolder);
    //     await expect(instance.transfer(recipient, new BN(balanceOfAccount + 1))).to.eventually.be.rejected;

    //     //check if the balance is still the same
    //     await expect(instance.balanceOf(initialHolder)).to.eventually.be.a.bignumber.equal(balanceOfAccount);

    // });

});
