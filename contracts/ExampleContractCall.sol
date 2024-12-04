// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Contract1 {
    mapping (address => uint) public balances;

    function deposit () public payable {
        balances[msg.sender] += msg.value;
    }

    receive() external payable {
        deposit();
    }
}

contract Contract2 {
    receive() external payable {}

    function depositOnContract1 (address _cons1) public  {
        // extarnal function
        //Contract1 one = Contract1(_cons1);
        //one.deposit{value: 10, gas: 100000}();

        // low-level calls if dont know its a smart contract
        // bytes memory payload = abi.encodeWithSignature("deposit()");
        // (bool success, ) = _cons1.call{value: 10, gas: 100000}(payload);
        // require(success);

        // low-level calls if dont know everything about function of this smart contract
        (bool success, ) = _cons1.call{value: 10, gas: 100000}("");
        require(success);
    }
}