import "@openzeppelin/contracts/ownership/Ownable.sol";

interface IPoolBoxGod { // should be Ownable.

    // create the box
    function invoke() returns (address);

    // timestamp of when it was invoked
    function invokedAt() returns (uint256);

    // the created box
    function poolBox() returns (address);

}
