// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract SampleMapping {
    mapping (uint => bool) public theMapping;
    mapping (address => bool) public theAddressMapping;

    mapping (uint => mapping (uint => bool)) public  uint2Uint2Bool;

    // similar set value of array 1D
    function setMapping (uint _index) public {
        theMapping[_index] = true;
    }

    function setAddressMapping () public {
        theAddressMapping[msg.sender] = true;
    }

    // similar set value of array 2D
    function setuint2Uint2Bool (uint _index1, uint _index2, bool _value) public {
        uint2Uint2Bool[_index1][_index2] = _value;
    }

}