// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library Address {

    address constant DEV = 0xb513434C6f64A8B464295Ce024191182b87E1c96;

    function asDev(address _dev) internal pure returns (address) {
        return (_dev == address(0)) ? DEV : _dev;
    }
}