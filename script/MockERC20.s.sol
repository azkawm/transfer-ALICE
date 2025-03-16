// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MockERC20} from "../src/mocks/MockERC20.sol";

contract MockERC20Script is Script{

    MockERC20 public mockERC20;
    //base mainnet "https://base-mainnet.g.alchemy.com/v2/IpWFQVx6ZTeZyG85llRd7h6qRRNMqErS"
    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("https://base-sepolia.g.alchemy.com/v2/IpWFQVx6ZTeZyG85llRd7h6qRRNMqErS"));
    }

    function run() public {
        uint256 privateKey = vm.envUint("DEPLOYER_WALLET_PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        mockERC20 = new MockERC20();
        vm.stopBroadcast();
    }
}