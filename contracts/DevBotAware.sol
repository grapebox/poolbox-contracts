// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./interfaces/IDevBotAware.sol";
import "./lib/Address.sol";

contract DevAware is IDevAware {
    using Address for address;

    modifier onlyDev() {
        require(msg.sender == _devInfo.dev);
        _;
    }

    DevInfo _devInfo;

    constructor(DevInfo memory _info) {
        require(_info.dev != address(0), "");
        _devInfo = _info;
        _devInfo.dev = _devInfo.dev.asDev();
    }

    function devInfo() public view returns (DevInfo memory) {
        return _devInfo;
    }
}

// contract MichaelDev is DevAware {
//     constructor() public {
//         DevInfo memory info = DevInfo({
//             dev: Address(0xb513434C6f64A8B464295Ce024191182b87E1c96),
//             fee: 0
//         });
//         super(info);
//     }
// }

contract BotAware is IBotAware {
    modifier onlyBot() {
        require(msg.sender == this.botInfo().bot);
        _;
    }

    modifier onlyBotMod() {
        require(msg.sender == this.botInfo().mod);
        _;
    }

    // PROPERTIES

    BotInfo _botInfo;

    // CONSTRUCTOR

    constructor(BotInfo memory _info) {
        _botInfo = _info;
    }

    // METHODS - public

    function botInfo() external view returns (BotInfo memory) {
        return _botInfo;
    }

    // METHODS - onlyBotMod

    function setBotInfo(BotInfo memory _bot) public onlyBotMod {
        // TODO: require something
        require(_bot.bot != address(0), "must have bot");
        require(_bot.mod != address(0), "must have mod");
        _botInfo.bot = _bot.bot;
    }
}

abstract contract DevBotAware is BotAware, DevAware {
    constructor(DevInfo memory _dev, BotInfo memory _bot)
        DevAware(_dev)
        BotAware(_bot)
    {}
}
