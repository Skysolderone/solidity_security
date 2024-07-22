// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./ReentrancyGuard.sol";

contract InsecureEhterVault is ReentrancyGuard {
    mapping(address => uint256) private userBalance;

    function deposit() external payable {
        userBalance[msg.sender] += msg.value;
    }

    function withdraw(uint256 _amount) external noReentrant {
        uint256 balance = getUserBalance(msg.sender);
        require(balance - _amount >= 0, "insufficient balance");
        userBalance[msg.sender] -= _amount;
        (bool success, ) = msg.sender.call{value: _amount}("");
        require(success, "Falied to send ether");
    }

    function getUserBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function getUserBalance(address _user) public view returns (uint256) {
        return userBalance[_user];
    }
}
