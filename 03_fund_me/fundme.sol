// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract FundMe{
   
    mapping (address => uint256) public addressToAmountFunded;
    address public owner;
    address[] public funders;

    constructor() public {
        owner = msg.sender;
    }
    
    function fund() payable public{

        // setting minimum value of $50 
        uint256 MINIMUM_USD = 1 * 10 ** 18;
        require(getConversionRate(msg.value) >= MINIMUM_USD, "you need to send more eth!");

        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);

    }

    function getVersion() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5fb1616F78dA7aFC9FF79e0371741a747D2a7F22);
        return priceFeed.version();
    }

    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5fb1616F78dA7aFC9FF79e0371741a747D2a7F22);
        (,int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer);
        // 30016152163518864000 : 18 decimals
        // 0.003091914122878889
        // 1000000000  0.000000030919141228
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        return ethAmountInUsd;
    }

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    function withdraw() payable public onlyOwner {

        // require(msg.sender == owner);
        msg.sender.transfer(address(this).balance);

        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
    }
}