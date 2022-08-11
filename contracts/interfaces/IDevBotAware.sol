// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
pragma experimental ABIEncoderV2;

interface IDevAware {

    struct DevInfo {
        address ;
        uint256 fee;
    }

    // is this better?
    function devInfo() returns (DevInfo memory);

}

interface IBotAware {

    struct BotInfo {
        address mod;
        address bot;
        uint256 fee;
    }

    function botInfo() returns (BotInfo memory);

    function setBotInfo(BotInfo memory info);

}

interface IDevBotAware is IDevAware, IBotAware {

}