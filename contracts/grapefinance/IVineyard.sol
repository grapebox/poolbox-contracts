// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// 0x28c65dcB3a5f0d456624AFF91ca03E4e315beE49
// https://snowtrace.io/address/0x28c65dcB3a5f0d456624AFF91ca03E4e315beE49#readContract
interface IVineyard {
    //
    function userInfo(uint256 pid, address depositor)
        external
        view
        returns (uint256, uint256);

    //    function userInfo() returns (amount uint256, rewardDebt uint256);

    function poolInfo(uint256 pid, address depositor)
        external
        view
        returns (
            address,
            uint256,
            uint256,
            uint256,
            bool
        );

    //    function poolInfo() returns (token address, allocPoint uint256, lastRewardTime uint256, accWinePerShare uint256, isStarted bool);

    function pendingShare(address user) external view returns (uint256);

    function deposit(uint256 pid, uint256 amount) external;

    function withdraw(uint256 pid, uint256 amount) external;
}
