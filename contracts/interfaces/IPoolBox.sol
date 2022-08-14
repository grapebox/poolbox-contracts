// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "./IDevBotAware.sol";
import "./lib/IOwnable.sol";

// TODO: What if this was an ERC4626 vault
interface IPoolBox is IBotAware, IDevAware, IOwnable {
    ////////////////////////////////////////////////////////////
    //
    // STRUCTS
    //
    struct PoolInfo {
        address pool;
        IERC20 token;
        IERC20 reward;
    }

    struct UsageStats {
        // deposit
        uint256 deposits; ///  count
        uint256 deposited; // volume
        // shake
        uint256 shakes; // count
        uint256 shaken; // volume

        // uint256 depositVolume; // quantity
        // uint256 depositCount; // quantity
        // uint256 shakeCount; // quantity
        // uint256 rewardVolume; // volume
    }

    ////////////////////////////////////////////////////////////
    //
    // PROPERTIES
    //
    ////////////////////////////////////////////////////////////

    function poolInfo() external returns (PoolInfo memory);

    function usageStats() external returns (UsageStats memory);

    ////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////
    //
    // PROPERTIES - EXTERNAL
    //
    ////////////////////////////////////////////////////////////

    // amount held in the underlying pool.
    function balance() external returns (uint256);

    // amount of rewards that can be withdrawn/shaken.
    function shakeable() external returns (uint256);

    ////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////
    //
    // ACTIONS - DEPOSIT
    //

    // deposit the pool's token to the pool.
    function deposit(uint256 amount) external;

    //
    // ACTIONS - SHAKE
    //

    // withdraw rewards from underlying pool, send them to the bot address.
    function shake() external returns (uint256);

    ////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////
}
