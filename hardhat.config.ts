////////////
// load hardhat features
import "@nomicfoundation/hardhat-toolbox";
import "@nomiclabs/hardhat-solhint";
import "hardhat-contract-sizer";
import "hardhat-deploy";
import "hardhat-docgen";
import "hardhat-interface-generator";
import "hardhat-spdx-license-identifier";
import "hardhat-tracer";
import "hardhat-watcher";

////////////
import "./tasks";
////////////

import { HardhatUserConfig } from "hardhat/config";
import {node_url, accounts} from './utils/network';
import {removeConsoleLog} from "hardhat-preprocessor";


/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
    solidity: {
        compilers: [
            {
                version: "0.8.0",
                settings: {
                    optimizer: {
                        enabled: true,
                        runs: 200,
                    },
                },
            },
            {
                version: "0.7.5",
                settings: {
                    optimizer: {
                        enabled: true,
                        runs: 200,
                    },
                },
            },
        ],
    },
    etherscan: {
        apiKey: process.env.ETHERSCAN_API_KEY,
    },
    gasReporter: {
        coinmarketcap: process.env.COINMARKETCAP_API_KEY,
        currency: "USD",
        enabled: process.env.REPORT_GAS === "true",
        // outputFile: `gas-${Date.now()}.json`,
        // outputFile: "gas.json",
        excludeContracts: [
            "examples",
            "flat",
            "mocks",
        ],
        // onlyCalledMethods: true,
        // showTimeSpent: true,
    },
    namedAccounts: {
        deployer: {
            default: 0, // here this will by default take the first account as deployer
        },
        tokenOwner: 1,
    },
    typechain: {
        outDir: "types",
        target: "ethers-v5",
    },
    preprocess: {
        eachLine: removeConsoleLog((bre) =>
            bre.network.name !== "hardhat" && bre.network.name !== "localhost"),
    },
    paths: {
        artifacts: "artifacts",
        cache: "cache",
        deploy: "deploy",
        deployments: "deployments",
        imports: "imports",
        sources: "contracts",
        tests: "tests",
    },
    networks: {
        fuji: {
            url: node_url("fuji"),
            accounts: accounts('fuji'),
            chainId: 43113,
            live: true,
            saveDeployments: true,
            tags: ["staging"],
            gasMultiplier: 2,
        },
        localhost: {
            saveDeployments: true,
            chainId: 31337,
            accounts: accounts('localhost'),
            gasPrice: 225000000000,
            throwOnTransactionFailures: true,
            loggingEnabled: true,
            url: 'http://localhost:8545',
        },
        hardhat: {
            saveDeployments: true,
            chainId: 31337,
            accounts: accounts('hardhat'),
            gasPrice: 225000000000,
            throwOnTransactionFailures: true,
            loggingEnabled: true,
            forking: {
                url: node_url("fork", {
                    defaultsTo: node_url("avax"),
                    required:true
                })!!,
                enabled: true,
                // blockNumber: 2975762
                // blockNumber: 13919447
            },
        },
    },
    deterministicDeployments: true,
};
