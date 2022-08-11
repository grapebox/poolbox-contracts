interface IBoxShop {

    function router() returns (address);

    function deposit(address token, uint256 amount);
    function deposits(address token, address depositor) returns (uint256);
    function deposits(address token, address depositor) returns (/* pool */ address, /* amount */uint256);

    function sharePrice(address token) returns (uint256);
    function poolShares(address pool, address depositor) returns (uint256);
    function sharesFor(address token, address depositor) returns (uint256);

    function supports(address token) returns (bool);

    function claim(uint tokenId) returns (uint256);
    function claimable(uint tokenId) returns (uint256);

}
