// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./StakingPoolStorage.sol";

abstract contract PoolManagement is StakingPoolStorage {
    event PoolCreated(uint256 poolId, uint256 rewardRate, uint256 externalPoolId);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    function createPool(uint256 _rewardRate, uint256 externalPoolId) 
        external 
        onlyOwner 
        returns (uint256) 
    {
        require(_rewardRate > 0, "Reward rate must be greater than 0");
        poolCount++;
        pools[poolCount] = Pool({
            rewardRate: _rewardRate,
            totalStaked: 0,
            totalRewardsPaid: 0
        });

        emit PoolCreated(poolCount, _rewardRate, externalPoolId);
        return poolCount;
    }
}