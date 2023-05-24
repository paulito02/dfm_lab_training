//SPDX-Licence-Identifier: MIT

pragma solidity ^0.8.10;


//build a smart contract that will allow my child to create fund once my child is 18 yrs old
contract ChildTrust {
    uint amount;

    address payable child; //payable
    address father; //nonpayable
    uint currentTimeStap = block.timestamp;  // to get the current time in other to set the time the child will be eligible to withdraw
    uint pay; 
    uint validAge = currentTimeStap + 18 * 365 * 24 * 60 *60; //setting a variable in which  must met the require or the value expected by the father before the child can be payed
    
    uint256 childAge;
    uint256 number_of_deposits;

    constructor(uint _amount, address payable _child,uint256 _childAge){
        amount = _amount;
        child = _child;
        childAge = currentTimeStap + (_childAge * 365 * 24 * 60 *60);
    }   
    modifier onlyChild {
        require (msg.sender == child);
        _;
    }
     // public, private, internal, external
    function withdraw() external  {// this is the payment function in which allow the child to withdraw
        require(childAge >= validAge, "the child must be 18 yrs or above in other to withdraw");
        child.transfer(amount);

    } 
    function deposit() external payable{// this is for the deposit by the father
        amount += msg.value;
        number_of_deposits++;
    }
}