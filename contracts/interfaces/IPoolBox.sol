import "./IBoxDevBot.sol";
import "./lib/IOwnable.sol";

interface IPoolBox {

    // customer funds deposit here, intended to be single-stake pool (Grape only)
    // bot calls harvest, withdraws the wine and sends
    function pool() returns (address);
    function token() returns (address);
    function reward() returns (address);

    // deposit the pool's token to the pool.
    function deposit(uint256 amount);
    function deposited() public view returns (address, uint256);

    // amount held in the underlying pool.
    function balance() returns (address, uint256);

    // volume of withdraws
    function shaken() returns (address, uint256);

    // amount of rewards that can be withdrawn/shaken.
    function shakeable() returns (uint256);

    // withdraw rewards from underlying pool, send them to the bot address.
    function shake() returns (uint256);

}
