// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address sender, uint256 amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
}

contract SimpleStaking {
    mapping(address => uint256) public stakedAmount;

    // Event emitted when a user stakes an amount
    event Staked(address indexed user, address indexed token, uint256 amount);

    // Event emitted when a user unstakes an amount
    event Unstaked(address indexed user, address indexed token, uint256 amount);

    // Function to stake an amount of ERC20 token
    function stake(address token, uint256 amount) external {
        require(amount > 0, "Cannot stake 0");

        // Transfer tokens from the user to the contract
        require(
            IERC20(token).transferFrom(msg.sender, address(this), amount),
            "Transfer failed"
        );

        stakedAmount[msg.sender] += amount;

        emit Staked(msg.sender, token, amount);
    }

    // Function to unstake the staked amount of ERC20 token
    function unstake(address token, uint256 amount) external {
        require(amount > 0, "Cannot unstake 0");
        require(
            amount <= stakedAmount[msg.sender],
            "Insufficient staked amount"
        );

        stakedAmount[msg.sender] -= amount;

        // Transfer tokens back to the user
        require(IERC20(token).transfer(msg.sender, amount), "Transfer failed");

        emit Unstaked(msg.sender, token, amount);
    }

    // Function to get the total staked amount of ERC20 token for a user
    function getStakedBalance(address user) external view returns (uint256) {
        return stakedAmount[user];
    }
}