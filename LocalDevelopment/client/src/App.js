import React, { Component } from "react";
import ItemManager from "./contracts/ItemManager.json";
import Item from "./contracts/Item.json";
import getWeb3 from "./getWeb3";
import "./App.css";

class App extends Component {
  state = { loaded: false, cost: 0, itemName: "exampleItem1" };
  
  componentDidMount = async () => {
    try {
      // Get network provider and web3 instance.
      this.web3 = await getWeb3();

      // Use web3 to get the user's accounts.
      this.accounts = await this.web3.eth.getAccounts();

      // Get the contract instance.
      const networkId = await this.web3.eth.net.getId();

      this.itemManager = new this.web3.eth.Contract(
        ItemManager.abi,
        ItemManager.networks[networkId] && ItemManager.networks[networkId].address,
      );

      this.item = new this.web3.eth.Contract(
        Item.abi,
        Item.networks[networkId] && Item.networks[networkId].address,
      );

      // Set web3, accounts, and contracts to the state, and then proceed with an
      // example of interacting with the contract's methods
      this.listenToPaymentEvent();
      this.setState({ loaded: true });

    } catch (error) {
      // Catch any errors for any of the above operations.
      alert(
        `Failed to load web3, accounts, or contract. Check console for details.`,
      );
      console.error(error);
    }
  };

  listenToPaymentEvent = () => {
    let self = this;
    this.itemManager.events.SupplyChainStep().on("data", async function(evt) {
      console.log(evt);
      let itemObj = await self.itemManager.methods.items(evt.returnValues._itemIndex).call();
      alert("Item " + itemObj._identifier + " was paid, deliver it now");
    });
  }

  handleInputChange = (event) => {
    const target = event.target;
    const value = target.type === "checkbox" ? target.checked : target.value;
    const name = target.name;
    this.setState({
      [name]: value
    });
  }

  handleSubmit = async () => {  // wait for the blockchain to come back with the results
    const { cost, itemName } = this.state;
    let result = await this.itemManager.methods.createItem(itemName, cost).send(
      { from: this.accounts[0] }
    );
    console.log('Resultado: ' + result);
    alert('Send ' + cost + ' Wei to ' + result.events.SupplyChainStep.returnValues._itemAddress);
  }

  render() {
    if (!this.state.loaded) {
      return <div>Loading Web3, accounts, and contract...</div>;
    }
    return (
      <div className="App">
        <h1>Supply Chain Example</h1>
        <h2>Items</h2>
        <h2>Add Elements</h2>
        Cost in wei: <input type="text" name="cost" value={this.state.cost} onChange={this.handleInputChange} />
        Item Identifier: <input type="text" name="itemName" value={this.state.itemName} onChange={this.handleInputChange} />
        <button type="button" onClick={this.handleSubmit}>Create new Item</button>
      </div>
        );
  }
}

        export default App;
