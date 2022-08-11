# Hardhat Boilerplate

 * [Hardhat Beginners Tutorial](https://hardhat.org/tutorial)

## Quick start

```sh
cp .env.example .env
yarn && yarn check-env
```

Once installed, let's run Hardhat's testing network:

```sh
yarn fork || npx hardhat node 
```

Then, on a new terminal, go to the repository's root folder and run this to
deploy your contract:

```sh
npx hardhat run scripts/legacy-deploy.js --network localhost
```

Finally, we can run the frontend with:

```sh
cd frontend && yarn && yarn start
```

Open [http://localhost:3000/](http://localhost:3000/) to see your Dapp. You will
need to have [Metamask](https://metamask.io) installed and listening to
`localhost 8545`.

## User Guide

You can find detailed instructions on using this repository and many tips in [its documentation](https://hardhat.org/tutorial).

- [Writing and compiling contracts](https://hardhat.org/tutorial/writing-and-compiling-contracts/)
- [Setting up the environment](https://hardhat.org/tutorial/setting-up-the-environment/)
- [Testing Contracts](https://hardhat.org/tutorial/testing-contracts/)
- [Setting up Metamask](https://hardhat.org/tutorial/boilerplate-project#how-to-use-it)
- [Hardhat's full documentation](https://hardhat.org/docs/)

For a complete introduction to Hardhat, refer to [this guide](https://hardhat.org/getting-started/#overview).

## What's Included?

This repository uses our recommended hardhat setup, by using our [`@nomicfoundation/hardhat-toolbox`](https://hardhat.org/hardhat-runner/plugins/nomicfoundation-hardhat-toolbox). When you use this plugin, you'll be able to:

- [ethers.js](https://docs.ethers.io/v5/) and the [`hardhat-ethers`](https://hardhat.org/hardhat-runner/plugins/nomiclabs-hardhat-ethers).
- Tests with [Mocha](https://mochajs.org/), [Chai](https://chaijs.com/) and our own [Hardhat Chai Matchers](https://hardhat.org/hardhat-chai-matchers).
- [Hardhat Network Helpers](https://hardhat.org/hardhat-network-helpers).
- Verify the source code of your contracts with [hardhat-etherscan](https://hardhat.org/hardhat-runner/plugins/nomiclabs-hardhat-etherscan).
- Get metrics on gas used via [hardhat-gas-reporter](https://github.com/cgewecke/hardhat-gas-reporter).
- Measure tests coverage with [solidity-coverage](https://github.com/sc-forks/solidity-coverage).

This project also includes [a sample frontend/Dapp](./frontend), which uses [Create React App](https://github.com/facebook/create-react-app).

## Troubleshooting

- `Invalid nonce` errors: if you are seeing this error on the `npx hardhat node`
  console, try resetting your Metamask account. This will reset the account's
  transaction history and also the nonce. Open Metamask, click on your account
  followed by `Settings > Advanced > Reset Account`.

## Setting up your editor

 * [Hardhat for Visual Studio Code](https://hardhat.org/hardhat-vscode) 
 * [Hardhat for IntelliJ](https://plugins.jetbrains.com/plugin/18551-hardhat)
