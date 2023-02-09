pragma solidity ^0.8.3;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Safe is Ownable {

    mapping (address => bool) private people;
    uint32 private balance;

//    event Deposit(uint amount, address who);
//    event Withdraw(uint amount, address who);

    constructor() payable {
    }

    function deposit() public payable {
    }

    function withdraw(int32 amount) public onlyAuth hasFunds(amount){
        msg.sender.transfer(amount);
    }

//    function transferTo(address _to, int32 amount) public onlyAuth hasFunds(amount){
//        _to.transfer(amount);
//    }

    function allow(address person) public onlyOwner {
        people[person] = true;
    }

    function disallow(address person) public onlyOwner {
        delete people[person];
    }

    function getBalance() external onlyAuth returns (uint){
        return address(this).balance;
    }

    modifier onlyAuth {
        require(people[msg.sender] == true, "UNAUTHORIZED ADDRESS");
        _;
    }

    modifier hasFunds(int amount) {
        require(address(this).balance >= amount, "Not enough balance");
        _;
    }

}