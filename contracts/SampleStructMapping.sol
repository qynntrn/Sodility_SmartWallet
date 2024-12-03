// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Struct_Mapping  {
    struct Transaction{
        uint amout;
        uint timestamp;

    }

    struct Balance{
        uint totalBalance;
        uint numDeposits;
        mapping (uint => Transaction) deposit;
        uint numWithdrawals;
        mapping (uint => Transaction) withdrawal;


    }
    mapping (address => Balance) public balances;

    function getDepositNum(address _from, uint _numDeposit) public view returns (Transaction memory) {
        return balances[_from].deposit[_numDeposit];
    }
    function Deposit () public payable {
        balances[msg.sender].totalBalance += msg.value;

        Transaction memory deposit = Transaction(msg.value, block.timestamp);
        balances[msg.sender].deposit[balances[msg.sender].numDeposits] = deposit;
        balances[msg.sender].numDeposits ++;
    }

    function withdraw(address payable _to, uint _amount) public {
        balances[msg.sender].totalBalance -= _amount;

        Transaction memory withdraws = Transaction(_amount, block.timestamp);
        balances[msg.sender].withdrawal[balances[msg.sender].numWithdrawals] = withdraws;
        balances[msg.sender].numWithdrawals ++;

        _to.transfer(_amount);
    }
    

}