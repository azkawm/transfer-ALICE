// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ToAlicePool} from "../src/TransferALICE.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract AlicePoolTest is Test{
    IERC20 public constant aliceToken = IERC20(0x623cD3a3EdF080057892aaF8D773Bbb7A5C9b6e9);
    ToAlicePool public alicePool;

    address alice = makeAddr("alice");
    address wallet = 0xF735211E78c44659141deC90bA13f0F0fcD013ac;

    event Transfer(address sender, address recipient, uint256 amount);

    function setUp() public {
        vm.createSelectFork("https://base-mainnet.g.alchemy.com/v2/IpWFQVx6ZTeZyG85llRd7h6qRRNMqErS", 27624017);

        alicePool = new ToAlicePool(0xF735211E78c44659141deC90bA13f0F0fcD013ac);
        deal(address(aliceToken), alice, 100e18);
    }

    function test_SafeTransferFrom_HappyPath() public{
        uint256 amount = 100e18;
        vm.startPrank(alice);
        IERC20(aliceToken).approve(address(alicePool), amount);
        console.log("balance alice before: ", IERC20(aliceToken).balanceOf(alice));
        console.log("balance contract before: ", IERC20(aliceToken).balanceOf(wallet));

        //check logged event
        vm.expectEmit(true, true, true, true);
        emit Transfer(alice, address(alicePool), amount);
        alicePool.transfer(amount);

        console.log("balance alice after: ", IERC20(aliceToken).balanceOf(alice));
        console.log("balance wallet after: ", IERC20(aliceToken).balanceOf(wallet));
        vm.stopPrank();
    }

    function test_SafeTransferFrom_UnhappyPath() public{
        uint256 amount = 0;
        vm.startPrank(alice);
        IERC20(aliceToken).approve(address(alicePool), amount);
        //check error
        vm.expectRevert(ToAlicePool.AmountShouldNotBeZero.selector);
        alicePool.transfer(amount);
        vm.stopPrank();
    }

}