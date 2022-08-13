// import {HardhatRuntimeEnvironment} from 'hardhat/types/runtime';
import {DeployFunction} from 'hardhat-deploy/types';
import {HardhatRuntimeEnvironment} from "hardhat/types/runtime";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
    const {deployments, getNamedAccounts} = hre;
    const {deploy} = deployments;

    const {deployer, tokenOwner} = await getNamedAccounts();

    const pid = 3; // GRAPE

    const poolInfo = {
        // GrapeFinance Vineyard
        pool: '0x28c65dcB3a5f0d456624AFF91ca03E4e315beE49',
        // Grape
        token: '0x5541D83EFaD1f281571B343977648B75d95cdAC2',
        // Wine
        reward: '0xC55036B5348CfB45a932481744645985010d3A44',
    };

    const devInfo = {
        dev: tokenOwner,
        fee: 1, // TODO: units?
    };

    const botInfo = {
        mod: deployer,
        bot: tokenOwner,
        fee: 1, // TODO: units?
    };

    await deploy('WinePoolBox', {
        from: deployer,
        args: [
            poolInfo,
            pid,
            devInfo,
            botInfo,
        ],
        log: true,
        deterministicDeployment: true,
    });
};

export default func;
func.tags = ['WinePoolBox'];