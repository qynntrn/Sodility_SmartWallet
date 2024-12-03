// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract SampleMapping2 {
    mapping (address => uint) public BalanceOfAddress;
    
    function sendMoney() public payable {
        BalanceOfAddress[msg.sender] += msg.value;
    }

    function getBalanceContract() public view returns (uint) {
        return address(this).balance;
    }

    function withdrawAll(address payable _to) public  {
        uint balance2SendOut = BalanceOfAddress[msg.sender];
        BalanceOfAddress[msg.sender] = 0;
        _to.transfer(balance2SendOut);
    }

}