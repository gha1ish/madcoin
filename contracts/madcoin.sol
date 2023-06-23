// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract madcoin {
    // Max number of madcoins available for sale
    uint public max_madcoins= 1000000;

    // USD to madcoin conversion rate

    uint public usd_to_madcoin=1000;

    // Total madcoins bought by investors

    uint public total_madcoins_bought=0;

    // mapping of investor to his equity in madcoins and usd

    mapping(address => uint) equity_madcoins;
    mapping(address => uint) equity_usd;

    //checking if an investor can buy madcoins

    modifier can_buy_madcoins(uint usd_invested){
        require( usd_invested * usd_to_madcoin + total_madcoins_bought < max_madcoins);
        _;
    }

    function equity_in_madcoins() public view returns (uint){

        return equity_madcoins[msg.sender];

    }

    function equity_in_usd() public view returns (uint){

        return equity_usd[msg.sender];

    }


    //Buying madcoins

    function buy_madcoins(uint usd_invested) public 
    can_buy_madcoins(usd_invested) {

        uint madcoins_bought = usd_invested * usd_to_madcoin;
        equity_madcoins[msg.sender] += madcoins_bought;
        equity_usd[msg.sender] += usd_invested;

        total_madcoins_bought += madcoins_bought;

    }

       //Selling madcoins

    function sell_madcoins(uint madcoins_sold) public  {

        equity_madcoins[msg.sender] -= madcoins_sold;
        equity_usd[msg.sender] = equity_madcoins[msg.sender]/usd_to_madcoin;

        total_madcoins_bought -= madcoins_sold;

    }
}  