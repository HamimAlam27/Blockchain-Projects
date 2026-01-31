pragma solidity ^0.6.0;

contract SimpleStorage{
    
    // uint256 public favNumber; public is technically view function
    uint256 favNumber;

    struct People{
        uint256 favNumber;
        string name;
    }

    People public person = People({favNumber: 2, name: "Siddharth"});

    function store(uint256 _favNumber) public{
        favNumber = _favNumber;
    }

    function retrieve() public view returns (uint256){
        return favNumber;
    }

    function doMath(uint256 number) public pure returns (uint256){
        return number + number;
    }


    People[] public people;
    mapping(string => uint256) public nameToFavNumber;

    function addPerson(string memory _name, uint256 _favNumber) public{
        // people.push(People({favNumber: _favNumber, name: _name}));
        people.push(People(_favNumber, _name));

        //retrieve favnumber with name
        nameToFavNumber[_name] = _favNumber;

    }
}