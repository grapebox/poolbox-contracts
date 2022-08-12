// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
pragma experimental ABIEncoderV2;

interface IPoolBoxGod { // should be Ownable.

    // create the box
    function invoke() external returns (address);

    // timestamp of when it was invoked
    function invokedAt() external returns (uint256);

    // the created box
    function poolBox() external returns (address);

}
