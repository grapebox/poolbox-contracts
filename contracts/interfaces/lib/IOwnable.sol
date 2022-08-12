// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IOwnable {
    function owner() external returns (address);
    function transferOwnership(address newOwner) external;
    function renounceOwnership() external;
}
