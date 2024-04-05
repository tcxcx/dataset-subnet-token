// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

contract PaymentSplitter {
    address public owner;
    IERC20 public usdt;

    mapping(address => uint256) public shares;
    uint256 totalShares;
    address[] public payees;

    event PaymentReceived(address indexed payer, uint256 amount);
    event SharesSet(address indexed payee, uint256 shares);
    event MoneyTransferred(address indexed payee, uint256 amount);

    constructor(address _usdt) {
        owner = msg.sender;
        usdt = IERC20(_usdt);
    }

    function setShares(
        address[] memory _payees,
        uint256[] memory _shares
    ) external {
        require(_payees.length == _shares.length, "Arrays length mismatch");
        require(msg.sender == owner, "Only owner can set shares");
        for (uint256 i = 0; i < _payees.length; i++) {
            shares[_payees[i]] = _shares[i];
            totalShares += _shares[i];
            payees.push(_payees[i]);
            emit SharesSet(_payees[i], _shares[i]);
        }
        distributeFunds();
    }

    function receiveUSDT(uint256 amount) external {
        usdt.transferFrom(msg.sender, address(this), amount);
        emit PaymentReceived(msg.sender, amount);
    }

    function buy(uint256 amount) external {
        usdt.transferFrom(msg.sender, address(this), amount);
        emit PaymentReceived(msg.sender, amount);
        distributeFunds();
    }

    function distributeFunds() public {
        for (uint256 i = 0; i < payeeCount(); i++) {
            uint256 amount = (usdt.balanceOf(address(this)) *
                shares[payees[i]]) / totalShares;
            usdt.transfer(payees[i], amount);
            emit MoneyTransferred(payees[i], amount);
        }
    }

    function payeeCount() public view returns (uint256) {
        return payees.length;
    }
}