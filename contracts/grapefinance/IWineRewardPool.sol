// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// https://snowtrace.io/address/0x28c65dcB3a5f0d456624AFF91ca03E4e315beE49#readContract
// NOTE: this is just copy/pasted from their code
// NOTE: that this pool has no minter key of wine (rewards).
// Instead, the governance will call wine distributeReward method and send reward to this pool at the beginning.
abstract contract WineRewardPool {

    struct UserInfo {
        uint256 amount; // How many LP tokens the user has provided.
        uint256 rewardDebt; // Reward debt. See explanation below.
    }

    // Info of each pool.
    struct PoolInfo {
        IERC20 token; // Address of LP token contract.
        uint256 allocPoint; // How many allocation points assigned to this pool. Wine to distribute per block.
        uint256 lastRewardTime; // Last time that wine distribution occurs.
        uint256 accWinePerShare; // Accumulated wine per share, times 1e18. See below.
        bool isStarted; // if lastRewardTime has passed
    }

    // governance
    address public operator;
    IERC20 public wine;

    // Info of each pool.
    PoolInfo[] public poolInfo;

    // Info of each user that stakes LP tokens.
    mapping(uint256 => mapping(address => UserInfo)) public userInfo;

    // Total allocation points. Must be the sum of all allocation points in all pools.
    uint256 public totalAllocPoint = 0;

    // The time when wine mining starts.
    uint256 public poolStartTime;

    // The time when wine mining ends.
    uint256 public poolEndTime;

    uint256 public winePerSecond = 0.00128253 ether; // 41000 wine / (370 days * 24h * 60min * 60s)
    uint256 public runningTime = 370 days; // 370 days
    uint256 public constant TOTAL_REWARDS = 41000 ether;

    // View function to see pending Wine on frontend.
    function pendingShare(uint256 _pid, address _user) virtual external view returns (uint256);
    // Deposit LP tokens.
    function deposit(uint256 _pid, uint256 _amount) virtual public;
    // Withdraw LP tokens.
    function withdraw(uint256 _pid, uint256 _amount) virtual external;
    // Withdraw without caring about rewards. EMERGENCY ONLY.
    function emergencyWithdraw(uint256 _pid) virtual public;

}
