// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Consumer {
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function deposit() public payable {}
}


contract SmartWallet {
    // 1. The wallet has one owner
    address payable public owner;

    constructor () {
        owner = payable(msg.sender);
    }

    // 2. The wallet should be able to receive funds, no matter what
    receive() external payable { }

    // 3. It is possible for the owner to spend funds on any kind of address, no matter if its a 
    //so-called Externally Owned Account (EOA - with a private key), or a Contract Address.

    function transfer (address payable _to, uint256 _amount, bytes memory _payload) public returns (bytes memory){
        if (msg.sender != owner ){
            // checking owner 
            require(allowed2Send[msg.sender], "You are not the owner of this contract");
            require(_amount <= allowance[msg.sender], "You do not have enough allowance");

            allowance[msg.sender] -= _amount;
        }
        
        // can send for EOA and the other smart contract.
        (bool success, bytes memory data) = _to.call{value: _amount}(_payload);
        require(success && (data.length == 0), "Transfer failed");
        return data;
    }

    // 4. It should be possible to allow certain people to spend up to a certain amount of funds.
    mapping (address => uint256) public allowance;
    mapping (address => bool) public allowed2Send;

    // to setup who can send eth, in the case some acc send 0 eth.
    function setAllowance(address _for, uint _amount) public {
        require(msg.sender == owner, "You are not the owner of this contract");
        allowance[_for] = _amount;

        if (_amount > 0){
            allowed2Send[_for] = true;
        } else {
            allowed2Send[_for] = false;
        }
    }

    // 5. It should be possible to set the owner to a different address by a minimum of 3 out of 5 
    //guardians, in case funds are lost.
    mapping (address => bool) public guardians;

    // set 3-5 guardians to change the owner
    function addGuardian(address _guardian, bool _isGuardian) public {
        require(msg.sender != owner, "You are not the owner of this contract");
        guardians[_guardian] = _isGuardian;
    }

    // set the new owner
    address payable newOwner;
    uint guardianVotes;
    uint public constant rangeGuardian4Reset = 3;
    mapping (address => mapping(address => bool)) nextOwnerGuadianVotedBool;

    // the vote function for guardians
    function setNewOwner(address payable _newOwner) public {
        require (guardians[msg.sender], "You are not guardian");
        require (nextOwnerGuadianVotedBool[_newOwner][msg.sender] == false, "You have already voted for this one");
        if (_newOwner != newOwner){
            newOwner = _newOwner;
            guardianVotes = 0;
        }
        guardianVotes++;

        if (guardianVotes >= rangeGuardian4Reset){
            owner = newOwner;
            newOwner = payable(address(0));

        }


    }
}