// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "./SimpleStorage.sol";

contract SimpleStorageFactory {
    SimpleStorage[] public simpleStorageArray;
    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore (uint _simpleStorageIndex, uint _simpleStorageNumber) public {
        // address and ABI
        SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        simpleStorage.store(_simpleStorageNumber);
    }

    function sfGet (uint256 _ssIndex) public view returns (uint256) {
        // SimpleStorage simpleStorage = SimpleStorage(simpleStorageArray[_ssIndex]);
        // return simpleStorage.retrieve();
        return simpleStorageArray[_ssIndex].retrieve(); // both ways work]
    }
}