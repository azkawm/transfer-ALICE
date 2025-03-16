// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {ToAlicePool} from "../src/TransferALICE.sol";

contract ToAlicePoolScript is Script{

    ToAlicePool public toAlicePool;

    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("https://base-mainnet.g.alchemy.com/v2/IpWFQVx6ZTeZyG85llRd7h6qRRNMqErS"));
    }

    function run() public {
        uint256 privateKey = vm.envUint("DEPLOYER_WALLET_PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        toAlicePool = new ToAlicePool(0x623cD3a3EdF080057892aaF8D773Bbb7A5C9b6e9);
        vm.stopBroadcast();
    }
}
// contract CarbonTokenScript is Script {
//     CarbonToken public carbonToken;

//     function setUp() public {
//         vm.createSelectFork(vm.rpcUrl("optimism_sepolia"));
//     }

//     function run() public {
//         uint256 privateKey = vm.envUint("DEPLOYER_WALLET_PRIVATE_KEY");
//         vm.startBroadcast(privateKey);
//         carbonToken = new CarbonToken("Milez Token", "MILEZ", 18, 100000000);
//         vm.stopBroadcast();
//     }
// }