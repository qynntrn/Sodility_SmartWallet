// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.6.12;

contract Exception {
    mapping (address => uint8) public balances;

    function deposit() public payable {
        assert(msg.value == uint8(msg.value));
        balances[msg.sender] += uint8(msg.value);
    }

    function withdraw (address _to, uint8 _amount) public {
        require(balances[_to] >= _amount, "not enough fund"); // fail if insufficient funds for this amount

        balances[msg.sender] -= _amount;
        payable(_to).transfer(_amount);
    }
}