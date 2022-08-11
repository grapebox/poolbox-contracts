interface IPoolBoxRouter {

    function makePool(address factory) returns (address);

    function swapPool(address pool) returns (address);

    function closePool(address pool) returns (address);
    function pausePool(address pool) returns (address);
    function blockPool(address pool) returns (address);

    function poolFor(address token) returns (address);

    function deposit(address token, uint256 amount);

}
