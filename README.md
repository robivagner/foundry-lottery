# About
A smart contract solidity lottery project that displays pretty cool ways to use automation and vrf from chainlink. 
I'm pretty hyped to show this kind of work and keep learning smart contract development. 
Stay stuned for my work in the future. Thanks!

# Getting started

## Requirements
- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you did it right if you can run `git --version` and you see a response like `git version x.x.x`
- [foundry](https://getfoundry.sh/)
  - You'll know you did it right if you can run `forge --version` and you see a response like `forge x.x.x`

## Quickstart
```
git clone https://github.com/robivagner/foundry-lottery
cd foundry-lottery
make
```

# Usage

## Deploy

Quick deploy
```
forge script script/DeployRaffle.s.sol
```

Deploy on anvil chain (2 terminal windows needed)
First terminal:
```
anvil
```

Second terminal:
```
forge script script/DeployRaffle.s.sol:DeployRaffle --rpc-url http://127.0.0.1:8545
```

Note: because of the way the mock is coded for the VRF you need to be on block number 1 at least for the code not to go into underflow. 
I advise to either just do vm.roll(block.number + 1) in the code or the easier way just do the command below instead of anvil to generate a block each 10 seconds. 
Wait for the block to generate then do the deploy command for it to work.
```
anvil --block-time 10
```

## Testing

If you want to do unit testing
```
forge test
```

If you want to do forked testing on the sepolia chain for example(the $SEPOLIA_RPC_URL is a enviromental variable check the deployment paragraph to see how it's done)

```
forge test --fork-url $SEPOLIA_RPC_URL
```

### Test coverage

To see the test coverage percentage

```
forge coverage
```

# Deployment to a testnet or mainnet

1. Setup environment variables

You'll want to set your `SEPOLIA_RPC_URL` and `PRIVATE_KEY` as environment variables. You can add them to a `.env` file, like this

```
SEPOLIA_RPC_URL=EXAMPLE_URL
PRIVATE_KEY=EXAMPLE_PRIVATE_KEY
ETHERSCAN_API_KEY=EXAMPLE_ETHERSCAN_API_KEY
```

Then you can type:

```
source .env
```

to use them in the command line after you saved the .env file.


!!PLEASE do NOT put your actual private key in the .env file it is NOT good practice. 
!!EITHER put the private key of a wallet you won't have actual money in OR use this command to store your private key interactively in a encrypted form:
```
cast wallet import <any_wallet_name_you_want> --interactive
```

2. Get testnet ETH

Head over to [faucets.chain.link](https://faucets.chain.link/) and get some testnet ETH. You should see the ETH show up in your metamask.

3. Deploy

This way it automatically create a subscriptions for you. The contract will deploy but it will probably fail 2 transactions because of foundry.
```
make deploy-sepolia
```
or
```
forge script script/DeployRaffle.s.sol:DeployRaffle --rpc-url $(SEPOLIA_RPC_URL) --account default --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY)
```

The better way to do this is to create a subscription using their site and passins the subscription ID on the HelperConfig.s.sol

[You can follow the documentation on how to register a Chainlink Automation Upkeep.](https://docs.chain.link/chainlink-automation/guides/register-upkeep)

To get the etherscan api key go to their [site](https://etherscan.io/), sign in, hover over your name and go to api keys. 
Then u can click add, give it a name, copy the API key token and put it in an enviromental variable in the .env file like shown above.

## Scripts

After deploying to a testnet or local net, you can run the scripts.

Using cast deployed locally example:

```
cast send <RAFFLE_CONTRACT_ADDRESS> "enterRaffle()" --value 0.1ether --private-key <PRIVATE_KEY> --rpc-url $SEPOLIA_RPC_URL
```

## Estimate gas

You can estimate how much gas things cost by running:

```
forge snapshot
```

And you'll see an output file called `.gas-snapshot`

# Thank you!

This was a fun project to make that was very helpful and fulfilling. I learned a lot and I am excited to share my journey!