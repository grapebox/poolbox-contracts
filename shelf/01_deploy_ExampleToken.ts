// import {HardhatRuntimeEnvironment} from 'hardhat/types/runtime';
import {DeployFunction} from 'hardhat-deploy/types';
import {HardhatRuntimeEnvironment} from "hardhat/types/runtime";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
    const {deployments, getNamedAccounts} = hre;
    const {deploy} = deployments;

    const {deployer, tokenOwner} = await getNamedAccounts();

    await deploy('ExampleToken', {
        from: deployer,
        args: [tokenOwner],
        log: true,
        deterministicDeployment: true,
    });
};

export default func;
func.tags = ['ExampleToken'];