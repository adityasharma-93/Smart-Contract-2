// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// SafeMath library to prevent overflows and underflows
library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;
        return c;
    }
}

contract Assessment {
    using SafeMath for uint256;

    address public owner;
    uint256 public balance;

    event Deposit(address indexed sender, uint256 amount);
    event Withdraw(address indexed sender, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner of this account");
        _;
    }

    constructor(uint256 initBalance) {
        owner = msg.sender;
        balance = initBalance;
    }

    function getBalance() public view returns (uint256) {
        return balance;
    }

    function deposit(uint256 _amount) public onlyOwner {
        uint256 _previousBalance = balance;

        balance = balance.add(_amount);

        assert(balance == _previousBalance.add(_amount));

        emit Deposit(msg.sender, _amount);
    }

    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function withdraw(uint256 _withdrawAmount) public onlyOwner {
        uint256 _previousBalance = balance;

        if (balance < _withdrawAmount) {
            revert InsufficientBalance(balance, _withdrawAmount);
        }

        balance = balance.sub(_withdrawAmount);

        assert(balance == _previousBalance.sub(_withdrawAmount));

        emit Withdraw(msg.sender, _withdrawAmount);
    }
}
