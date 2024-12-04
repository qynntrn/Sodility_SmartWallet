// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Sender {
    receive() external payable {}

    function withdrawTransfer (address payable _to) public {
        _to.transfer(10);
    }

    function withdrawSend (address payable _to) public {
        bool status = _to.send(10);
        require(status, "Failed to send");
    }
}

contract ReceiveNoAction {
    function balances() public view returns (uint) {
        return address(this).balance;
    }
    receive() external payable {}
}

contract ReceiveAction {
    uint public blancesReceive;
    receive() external payable {
        blancesReceive += msg.value;
    }

    function balances() public view returns (uint) {
        return address(this).balance;
    }
}