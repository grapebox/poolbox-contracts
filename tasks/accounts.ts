import { task } from "hardhat/config";

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
    // @ts-ignore
    const accounts = await hre.ethers.getSigners();

    for (const account of accounts) {
        console.log(account.address);
    }
});

task("balance", "Prints the balance")
    .addPositionalParam("address", "The address of the account")
    .setAction(async (taskArgs, hre) => {
        // @ts-ignore
        // const accounts = await hre.ethers.getSigners();

        console.log(
            hre.ethers.utils.formatEther(await hre.ethers.provider.getBalance(taskArgs.address))
        );
    });