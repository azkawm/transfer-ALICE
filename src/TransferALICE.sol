// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ToAlicePool{
    
    using SafeERC20 for IERC20;
    
    //IERC20 public constant aliceToken = IERC20(0x623cD3a3EdF080057892aaF8D773Bbb7A5C9b6e9);
    IERC20 public aliceToken;

    address walletCustody;

    event Transfer(address sender, address wallet, uint256 amount);

    error AmountShouldNotBeZero();

    constructor(address wallet, address token){

        walletCustody = wallet;
        aliceToken = IERC20(token);    

    }

    function transfer(uint256 amount) public {

        if(amount == 0) revert AmountShouldNotBeZero();

        aliceToken.safeTransferFrom(msg.sender, walletCustody, amount);
        
        emit Transfer(msg.sender, address(this), amount);
    }
}