// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IPoolBoxRouter {

    function makePool(address factory) external returns (address);

    function deposit(address token, uint256 amount) external;

    function poolOf(address token) external returns (address);

}
