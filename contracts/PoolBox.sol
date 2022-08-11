import "./interfaces/IPoolBox.sol";
import "./Box.sol";
import "./DevBotBox.sol";

abstract contract PoolBox is Ownable, DevBotBox, IPoolBox {

    struct PoolInfo {
        address pool;
        IERC20 token;
        IERC20 reward;
    }

    struct UsageStats {
        uint256 depositVolume;  // quantity
        uint256 depositCount;   // quantity
        uint256 shakeCount;     // quantity
        uint256 rewardVolume;   // volume
    }

    PoolInfo poolInfo;
    UsageStats usageStats;

    constructor(PoolInfo memory _info) public {
        poolInfo = _info;
    }

    function deposit(uint256 amount) public {
        // require(msg.sender == poolInfo.pool);
        require(amount > 0);
        // slurp money into us.
        this.poolInfo.token.transferFrom(msg.sender, address(this), amount);
        
        this.usageStats.depositCount ++;  // TODO: safe increment?
        this.usageStats.depositVolume += amount;
        
        this._poolTokenDeposit();
    }

    function deposited() public view returns (address, uint256) {
        return (poolInfo.token, this.usageStats.depositVolume;)
    }

    function pool() public view returns (address) {
        return this.poolInfo.pool;
    }

    function token() public view returns (address) {
        return this.poolInfo.token;
    }

    function reward() public view returns (address) {
        return this.poolInfo.reward;
    }

    function shake() {
        // transfer funds to the bot.
        this._poolRewardClaim();
        this.poolInfo.reward.transfer(this.poolInfo.bot, this.usageStats.rewardVolume);
    }

    function shaken() public view returns (address, uint256) {
        return (poolInfo.reward, this.usageStats.rewardVolume;)
    }

    function balance() public view returns (address, uint256) {
        // return this.poolInfo.token.balanceOf(address(this));
        return (poolInfo.token, this._poolBalance());
    }

    // TODO: children should deposit into pool.
    abstract function _poolTokenDeposit() internal;
    abstract function _poolRewardClaim() internal;

    abstract function _poolTokenBalance() public view returns (uint256);
    abstract function _poolRewardBalance() public view returns (uint256);

}
