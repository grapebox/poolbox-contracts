// This is an example test file. Hardhat will run every *.js file in `test/`,
// so feel free to add new ones.

// Hardhat tests are normally written with Mocha and Chai.

// We import Chai to use its asserting functions here.
const { expect } = require("chai");

// We use `loadFixture` to share common setups (or fixtures) between tests.
// Using this simplifies your tests and makes them run faster, by taking
// advantage or Hardhat Network's snapshot functionality.
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
const { ethers } = require("hardhat");

// `describe` is a Mocha function that allows you to organize your tests.
// Having your tests organized makes debugging them easier. All Mocha
// functions are available in the global scope.
//
// `describe` receives the name of a section of your test suite, and a
// callback. The callback must define the tests of that section. This callback
// can't be an async function.
describe("WinePoolBox", function () {

  const WINE_PIDS = {
    GRAPE: 3,
  }

  async function getPoolInfo() {
    const poolInfo = {
      // GrapeFinance Vineyard
      pool: '0x28c65dcB3a5f0d456624AFF91ca03E4e315beE49',
      // Grape
      token: '0x5541D83EFaD1f281571B343977648B75d95cdAC2',
      // Wine
      reward: '0xC55036B5348CfB45a932481744645985010d3A44',
    };
    return poolInfo;
  }

  async function getDevInfo() {
    const devInfo = {
      dev: await (await ethers.getNamedSigner('dev')).getAddress(),
      fee: 1, // TODO: units?
    };

    return devInfo;
  }

  async function getBotInfo() {
    const botInfo = {
      mod: await (await ethers.getNamedSigner('deployer')).getAddress(),
      bot: await (await ethers.getNamedSigner('bot')).getAddress(),
      fee: 1, // TODO: units?
    };

    return botInfo;
  }

  // We define a fixture to reuse the same setup in every test. We use
  // loadFixture to run this setup once, snapshot that state, and reset Hardhat
  // Network to that snapshopt in every test.
  async function deployWineFixture() {
    const Box = await ethers.getContractFactory("WinePoolBox");
    const [deployer, mod, dev, bot, tokenOwner, addr1, addr2] = await ethers.getSigners();

    const botInfo = await getBotInfo();
    const devInfo = await getDevInfo();
    const poolInfo = await getPoolInfo();
    const pid = WINE_PIDS.GRAPE;

    const ERC20 = require('../ABI/ERC20.json')

    const TOKENS = {
      GRAPE: '0x5541D83EFaD1f281571B343977648B75d95cdAC2',
      WINE: '0xC55036B5348CfB45a932481744645985010d3A44',
    }

    const box = await Box.deploy(
      poolInfo,
      WINE_PIDS.GRAPE,
      devInfo,
      botInfo,
    );

    await box.deployed();

    const tokenHolder = null;

    // Fixtures can return anything you consider useful for your tests
    return {
      Box, box,
      tokens: {
        token: await ethers.getContractAt(ERC20, TOKENS.GRAPE),
        reward: await ethers.getContractAt(ERC20, TOKENS.WINE),
      },
      info: {
        pid,
        botInfo,
        devInfo,
        poolInfo,
      },
      signers: {
        deployer,
        mod,
        dev,
        addr1,
        addr2
      },
    };
  }

  async function loadWinePoolBox() {
    return loadFixture(deployWineFixture);
  }

  // You can nest describe calls to create subsections.
  describe("Deployment", function () {
    it("Should set the right owner", async function () {
      const { box, signers } = await loadFixture(deployWineFixture);

      // This test expects the owner variable stored in the contract to be
      // equal to our Signer's owner.
      expect(await box.owner()).to.equal(signers.mod.address);
    });


    it('deploy - poolInfo', async function () {
      const { Box, box, info, signers } = await loadWinePoolBox();

      const poolInfo = await box.poolInfo();

      expect(poolInfo.token, "poolInfo.token").to.equal(info.poolInfo.token);
      expect(poolInfo.reward, "poolInfo.reward").to.equal(info.poolInfo.reward);
      expect(poolInfo.pool, "poolInfo.pool").to.equal(info.poolInfo.pool);
    })

    it('deploy - botInfo', async function () {
      const { Box, box, info, signers } = await loadWinePoolBox();

      const botInfo = await box.botInfo();

      expect(botInfo.bot, "botInfo.bot").to.equal(info.botInfo.bot);
      expect(botInfo.mod, "botInfo.mod").to.equal(info.botInfo.mod);
      expect(botInfo.fee, "botInfo.fee").to.equal(info.botInfo.fee);

    });

    it('deploy - pid', async function () {
      const { Box, box, info, signers } = await loadWinePoolBox();

      const pid = await box.pid();

      expect(pid, "pid").to.equal(info.pid);

    });

    it('Should have 0 deposits', async function () {
      const { Box, box, info, signers } = await loadWinePoolBox();

      const usageStats = await box.usageStats();

      expect(usageStats.deposits, "usageStats.deposits").to.equal(0);
      expect(usageStats.deposited, "usageStats.").to.equal(0);
      expect(usageStats.shakes, "usageStats.shakes").to.equal(0);
      expect(usageStats.shaken, "usageStats.shaken").to.equal(0);

    });

    // it("Should assign the total supply of tokens to the owner", async function () {
    //   const { box, owner } = await loadFixture(deployWineFixture);
    //   const ownerBalance = await hardhatToken.balanceOf(owner.address);
    //   expect(await box.totalSupply()).to.equal(ownerBalance);
    // });
  });

  // describe("Transactions", function () {
  //   it("Should transfer tokens between accounts", async function () {
  //     const { hardhatToken, owner, addr1, addr2 } = await loadFixture(deployTokenFixture);
  //     // Transfer 50 tokens from owner to addr1
  //     await expect(hardhatToken.transfer(addr1.address, 50))
  //       .to.changeTokenBalances(hardhatToken, [owner, addr1], [-50, 50]);

  //     // Transfer 50 tokens from addr1 to addr2
  //     // We use .connect(signer) to send a transaction from another account
  //     await expect(hardhatToken.connect(addr1).transfer(addr2.address, 50))
  //       .to.changeTokenBalances(hardhatToken, [addr1, addr2], [-50, 50]);
  //   });

  //   it("should emit Transfer events", async function () {
  //     const { hardhatToken, owner, addr1, addr2 } = await loadFixture(deployTokenFixture);

  //     // Transfer 50 tokens from owner to addr1
  //     await expect(hardhatToken.transfer(addr1.address, 50))
  //       .to.emit(hardhatToken, "Transfer").withArgs(owner.address, addr1.address, 50)

  //     // Transfer 50 tokens from addr1 to addr2
  //     // We use .connect(signer) to send a transaction from another account
  //     await expect(hardhatToken.connect(addr1).transfer(addr2.address, 50))
  //       .to.emit(hardhatToken, "Transfer").withArgs(addr1.address, addr2.address, 50)
  //   });

  //   it("Should fail if sender doesn't have enough tokens", async function () {
  //     const { hardhatToken, owner, addr1 } = await loadFixture(deployTokenFixture);
  //     const initialOwnerBalance = await hardhatToken.balanceOf(
  //       owner.address
  //     );

  //     // Try to send 1 token from addr1 (0 tokens) to owner (1000 tokens).
  //     // `require` will evaluate false and revert the transaction.
  //     await expect(
  //         hardhatToken.connect(addr1).transfer(owner.address, 1)
  //     ).to.be.revertedWith("Not enough tokens");

  //     // Owner balance shouldn't have changed.
  //     expect(await hardhatToken.balanceOf(owner.address)).to.equal(
  //       initialOwnerBalance
  //     );
  //   });
  // });
});
