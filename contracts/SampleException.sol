// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.6.12;

contract Exception {
    mapping (address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw (address _to, uint _amount) public {
        require(balances[_to] >= _amount, "not enough fund"); // fail if insufficient funds for this amount

        balances[msg.sender] -= _amount;
        payable(_to).transfer(_amount);
    }
}