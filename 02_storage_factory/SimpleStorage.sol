// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract SimpleStorage{

    uint256 favNumber;

    struct People{
        string name;
        uint256 favNumber;
    }

    mapping(string => uint256) public nameToFavNumber;

    People[] public people;

    function addPerson(string memory _name, uint256 _favNumber) public {
        people.push(People(_name, _favNumber));
        nameToFavNumber[_name] = _favNumber;
    }

    function store(uint256 _favNumber) public {
        favNumber = _favNumber;
    }

    function retrieve() public view returns (uint256){
        return favNumber;
    }
}