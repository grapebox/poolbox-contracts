// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IPoolBoxShop {

    function router() external returns (address);

    function deposit(address token, uint256 amount) external ;
    function deposits(address token, address depositor) external returns (/* pool */ address, /* amount */ uint256);

    function sharePrice(address token) external returns (uint256);
    function poolShares(address pool, address depositor) external returns (uint256);
    function sharesFor(address token, address depositor) external returns (uint256);

    function accepts(address token) external  returns (bool);

    function claim(uint tokenId) external returns (uint256);
    function claimable(uint tokenId) external returns (uint256);

}
