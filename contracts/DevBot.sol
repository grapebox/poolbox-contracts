// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
pragma experimental ABIEncoderV2;

import "./interfaces/IDevBot.sol";

/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details
/// @param Documents a parameter just like in doxygen (must be followed by parameter name) is IDevAwar/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details
/// @param Documents a parameter just like in doxygen (must be followed by parameter name)
abstract contract DevAware {

    modifier onlyDev {
        require(msg.sender == devInfo.dev);
        _;
    }

    struct DevInfo {
        address dev;
        uint256 fee;
    }

    public DevInfo devInfo;

    constructor(DevInfo _info) public {
        devInfo = _info;
    }

    function devInfo() returns (DevInfo) {
        return this.devInfo;
    }
}

abstract contract BotAware is IBotAware {

    modifier onlyBot {
        require(msg.sender == botInfo.bot);
        _;
    }

    modifier onlyBotMod {
        require(msg.sender == botInfo.mod);
        _;
    }

    struct BotInfo {
        address mod;
        address bot;
        uint256 fee;
    }

    public BotInfo botInfo;

    constructor(BotInfo _info) public {
        botInfo = _info;
    }

    function setBot(BotInfo memory _bot) public onlyBotMod {
        // TODO: require something
        require(_bot != address(0));
        botInfo.bot = _bot;
    }

    function botFee() public view returns (uint256) {
        return this.botInfo.fee;
    }

}

abstract contract DevBotAware is BotAware, DevAware {

    constructor(BotInfo _bot, DevInfo _dev) 
        BotAware(_bot) 
        DevAware(_dev) {

    }

}