// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Wallet {
    PaymentReceive public payment;

    function payContract() public payable {
        payment = new PaymentReceive(msg.sender, msg.value);
    }
}

contract PaymentReceive {
    address public from;
    uint public value;

    constructor(address _from, uint _value) {
        from = _from;
        value = _value;
    }
}


// struct is cheaper than construct
contract Wallet2 {
    struct PaymentReceiveStruct {
        address from;
        uint value;
    }

    PaymentReceiveStruct public payment;

    function payContract() public payable {
        payment = PaymentReceiveStruct(msg.sender, msg.value);
    }
    
    
}

