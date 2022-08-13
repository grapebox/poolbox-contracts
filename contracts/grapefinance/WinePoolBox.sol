// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../PoolBox.sol";
import "./IVineyard.sol";

contract WinePoolBox is PoolBox {
    // this is the avalanche/prod address.
    address public immutable GRAPE_TOKEN =
        0x5541D83EFaD1f281571B343977648B75d95cdAC2;

    address public immutable WINE_TOKEN =
        0xC55036B5348CfB45a932481744645985010d3A44;

    address public immutable VINEYARD =
        0x28c65dcB3a5f0d456624AFF91ca03E4e315beE49;

    // FIELDS

    uint256 public immutable pid;

    // CONSTRUCTORS

    constructor(
        PoolInfo memory _pool,
        uint256 _pid,
        DevInfo memory _dev,
        BotInfo memory _bot
    ) PoolBox(_pool, _dev, _bot) {
        pid = _pid;
        // transferOwnership(newOwner); TODO: should we transfer to a controller?
    }

    /// INTERNAL METHODS

    // TODO: children should deposit into pool.
    function _poolTokenDeposit() internal override {
        // deposit everything we have
        IVineyard(_poolInfo.pool).deposit(
            pid,
            _poolInfo.token.balanceOf(address(this))
        );
    }

    function _poolRewardClaim() internal override {
        // GrapeFinanceVineyard withdraws WINE/Rewards within the withdraw function.
        IVineyard(_poolInfo.pool).withdraw(pid, 0);
    }

    function _poolTokenBalance()
        internal
        view
        override
        returns (uint256 amount)
    {
        (amount, ) = IVineyard(_poolInfo.pool).userInfo(pid, address(this));
    }

    function _poolRewardBalance() internal view override returns (uint256) {
        // user.amount.mul(pool.accWinePerShare).div(1e18).sub(user.rewardDebt)
        return IVineyard(_poolInfo.pool).pendingShare(address(this));
    }
}
