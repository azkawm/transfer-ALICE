// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {ToAlicePool} from "../src/TransferALICE.sol";

contract ToAlicePoolScript is Script{

    ToAlicePool public toAlicePool;
    //base mainnet "https://base-mainnet.g.alchemy.com/v2/IpWFQVx6ZTeZyG85llRd7h6qRRNMqErS"
    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("https://base-sepolia.g.alchemy.com/v2/IpWFQVx6ZTeZyG85llRd7h6qRRNMqErS"));
    }

    function run() public {
        uint256 privateKey = vm.envUint("DEPLOYER_WALLET_PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        toAlicePool = new ToAlicePool(0x623cD3a3EdF080057892aaF8D773Bbb7A5C9b6e9,0x93312e42bf55Ea9B023E988c1D3C326B18a1B57A);
        vm.stopBroadcast();
    }
}