// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract WillThrow {
    function test () public pure {
        //require ( false,"error message");// use for error logging; Error catch
        //assert(false); // use for error code; panic catch
        revert("test reverted");// use for error bytes; not both of them
    }
}

contract ErrorHanding {
    event ErrorLogging (string  reason);
    event ErrorCode (uint code);
    event ErrorLogBytes (bytes lowBytes);
    function cathError () public  {
        WillThrow will = new WillThrow();
        try will.test(){
            // ...
        } catch Error (string memory reason){
            emit ErrorLogging(reason);
        } catch Panic (uint numcode) {
            emit ErrorCode(numcode);
        } catch (bytes memory lowBytes){
            emit ErrorLogBytes(lowBytes);
        }

    }
}
