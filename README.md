# StarkNet graffiti
A smol project to send graffitis between StarkNet and Ethereum

## Introduction
### Disclaimer
Don't expect any kind of benefit from using this, other than learning a bunch of cool stuff about StarNet, the first general purpose validity rollup on the Ethereum Mainnnet. 

### How it works
We use the [L1 <-> L2 messaging bridge](https://www.cairo-lang.org/docs/hello_starknet/l1l2.html) of Starknet to send a message to Mainnet. The message is then used in an event emitted on Mainnet, and is kept in the logs of Ethereum forever! 

In the alpha phase, transactions are free on StarkNet, so you can try this without having to bridge any money to Starknet. 

You can use this project to graff on Mainnet, graff on StarkNet, or deploy your own graffer.

### Why?
Why not? I understand things things better when I tinker with them. This is a simple project to understand what it means for StarkNet to be deployed on Mainnet, and how messaging between StarkNet and Mainnet works. 

## Setting up
This project uses [Truffle](https://www.trufflesuite.com/truffle) and the [cairo-lang](https://pypi.org/project/cairo-lang/) python package. 
There are easier ways to manage your smart contracts deployments on StarkNet, and the project will evolve to integrate them. If you want to help with this, look at the "contributing" section below.

### Setting up truffle
If you don't have truffle installed on your machine, run
> npm install truffle
To install it locally in the repo. Then [configure it](https://www.trufflesuite.com/guides/using-infura-custom-provider). If you want to try on testnet, select the Goerli testnet.

### Setting up Cairo
Go [here](https://www.cairo-lang.org/docs/quickstart.html) for installation instructions.

### Graffing on Mainnet
So you want to deface Testnet huh? Simple.
- Make sure you [set up](###-Setting-up-Cairo) properly
- Compile the program with `starknet-compile contracts/graffiti.cairo \
    --abi contracts/graffiti-abi.json \
    --output contracts/graffiti-compiled.json `
- Use [this website](https://onlineasciitools.com/convert-ascii-to-decimal) to encode your message in decimal. Make sure to disable "decimal spacing" so you get a value like "123456" rather than "12 34 56"
- Select the mainnet Alpha network `export STARKNET_NETWORK=alpha-mainnet`
- Send this command `starknet invoke \
    --address 0x00813b30be862c2267ccf6dc2719297cb0cb8c782cb57091992d831aab4083d1 \
    --abi contracts/graffiti-abi.json \
    --function paint_graffiti \
    --inputs <your message encode in decimal>`
- Congrats! Your message is en route to mainnet.
- You can look up your transaction on [Voyager](https://voyager.online/). It may take a few hours before it is included in a block. Don't worry, it will show up there
- You can see your message in the [Messaging section](https://voyager.online/contract/0x00813b30be862c2267ccf6dc2719297cb0cb8c782cb57091992d831aab4083d1#messages) of the explorer

So now you wait for a few hours, for the state update to be published to mainnet.
 

### Graffing from Testnet
Curious about going the opposite route?


## Deployments
- Mainnet graffer [here](https://etherscan.io/address/0xc010818276eb5dff6cc462217c66ee7648fb8d8b)

## Contributing
This project was done in a few hours, and can be made better; your contributions are welcome! Here are things that you can do to help:
- Create a cool frontend to write from starknet to mainnet using [Starknet JS](https://www.starknetjs.com/index.html)
- Create a cool frontend to write from mainnet to starknet using web3
- Create a cool frontend to emit the event on mainnet using web3
