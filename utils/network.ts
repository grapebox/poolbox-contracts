const CHAINS: ChainEntry[] = require('../constants/chains.json')

// {
//     "chain": "ETH",
//     "rpc": [
//          "https://mainnet.infura.io/v3/${INFURA_API_KEY}",
//          "wss://mainnet.infura.io/ws/v3/${INFURA_API_KEY}",
//          "https://api.mycryptoapi.com/eth",
//          "https://cloudflare-eth.com"
//      ],
//     "shortName": "eth",
//     "chainId": 1,
//     "networkId": 1,
// },

export type ChainEntry = {
    chain: string,
    rpc: string[],
    shortName: string,
    chainId: number,
    networkId: number,
}

export function try_json(networkName: string, {
    required,
    defaultsTo
}: { defaultsTo?: string, required: boolean } = {required: false}): string {
    const chain = CHAINS.find((c: { shortName: string }) => networkName.toLowerCase() === c.shortName.toLowerCase());

    return withCheckedDefault(chain?.rpc[0], defaultsTo, required, `No RPC url found for ${networkName}`);
}

export function try_env(networkName: string, {
    required,
    defaultsTo
}: { defaultsTo?: string, required: boolean } = {required: false}): string {
    let uri = process.env['ETH_NODE_URI_' + networkName.toUpperCase()] || process.env.ETH_NODE_URI;

    if (uri) {
        uri = uri.replace('{{networkName}}', networkName);
    }

    if (isBlank(uri)) {
        if (networkName === 'localhost') {
            return 'http://localhost:8545';
        }

        // throw new Error(`environment variable "ETH_NODE_URI" not configured `);
    }

    if (uri?.indexOf('{{') >= 0) {
        throw new Error(
            `invalid uri or network not supported by node provider : ${uri}`
        );
    }

    return withCheckedDefault(uri, defaultsTo, required, `not env for ${networkName}`);
}

export function node_url(networkName: string, {
    required,
    defaultsTo
}: { defaultsTo?: string, required: boolean } = {required: false}): string {
    if (networkName) {
        const envs = try_env(networkName);
        if (envs)
            return envs;

        const chains = try_json(networkName);
        if (chains)
            return chains

        return withCheckedDefault(null, defaultsTo, required, `networkName "${networkName}" not supported`);
    }
}

export function getMnemonic(networkName?: string): string {
    if (networkName) {
        const mnemonic = process.env['MNEMONIC_' + networkName.toUpperCase()];
        if (mnemonic && mnemonic !== '') {
            return mnemonic;
        }
    }

    const mnemonic = process.env.MNEMONIC;
    if (!mnemonic || mnemonic === '') {
        return 'test test test test test test test test test test test junk';
    }
    return mnemonic;
}

export function accounts(networkName?: string): { mnemonic: string } {
    return {mnemonic: getMnemonic(networkName)};
}

function checkString(value: string, required: boolean, message:string = `value is required`): string {
    if (!value && required) {
        throw new Error(message)
    }
    return value;
}

function withCheckedDefault(value: string, defaultsTo: string, required: boolean, message:string): string {
    if (!value || !value.length) {
        value = defaultsTo
    }
    return checkString(value, required, message);
}

function isBlank(string:string) {
    return !string || !string.length;
}
