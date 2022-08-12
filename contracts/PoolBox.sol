// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "./interfaces/IPoolBox.sol";
import "./Box.sol";
import "./DevBotAware.sol";

abstract contract PoolBox is Ownable, DevBotAware, IPoolBox {
    ///
    /// STRUCTS

    /// PROPERTIES

    IPoolBox.PoolInfo public _poolInfo;
    IPoolBox.UsageStats public _usageStats;

    /// CONSTRUCTOR

    constructor(
        PoolInfo memory _pool,
        DevInfo memory _dev,
        BotInfo memory _bot        
    ) DevBotAware(_dev, _bot) {
        _poolInfo = _pool;
        _usageStats = UsageStats(0, 0, 0, 0);
    }

    /// PUBLIC METHODS

    /// PUBLIC METHODS - ACTIONS

    function deposit(uint256 amount) public {
        // require(msg.sender == _poolInfo.pool);
        require(amount > 0, "cheapskate");

        // MODIFY INTERNAL STATE
        _usageStats.deposits++; // TODO: safe increment?
        _usageStats.deposited += amount;

        // DO EXTERNAL SHIT (slurp money into us.)
        _poolInfo.token.transferFrom(msg.sender, address(this), amount);

        // EXECUTE POOL ACTION
        _poolTokenDeposit();
    }

    function shake() external returns (uint256) {
        // transfer funds to the bot.
        _poolRewardClaim();

        return _transferRewardsToBot();
    }

    function flush() external {
        _transferRewardsToBot();
    }

    function _transferRewardsToBot() internal returns (uint256) {
        uint256 amount = balanceOfRewardToken();
        _poolInfo.reward.transfer(_botInfo.bot, amount);
        return amount;
    }

    ////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////

    /// PUBLIC METHODS - VIEWS

    function poolInfo() external view returns (PoolInfo memory) {
        return _poolInfo;
    }

    function usageStats() external view returns (UsageStats memory) {
        return _usageStats;
    }

    function balanceOfRewardToken() public view returns (uint256) {
        return _poolInfo.token.balanceOf(address(this));
    }

    function balance() public view returns (uint256) {
        // return this._poolInfo.token.balanceOf(address(this));
        return _poolTokenBalance();
    }

    function shakeable() external view returns (uint256) {
        return _poolRewardBalance();
    }

    ////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////

    // TODO: children should deposit into pool.
    function _poolTokenDeposit() virtual internal;

    function _poolRewardClaim() virtual internal;

    function _poolTokenBalance() virtual internal view returns (uint256);

    function _poolRewardBalance() virtual internal view returns (uint256);
}
