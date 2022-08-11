interface IOwnable {
    function owner() returns (address);
    function transferOwnership(address newOwner);
    function renounceOwnership();
}
