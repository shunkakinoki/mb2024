// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {Test, console2} from "forge-std/Test.sol";
import {Mona2024BirthdayNFT} from "../src/Mona2024BirthdayNFT.sol";

contract Mona2024BirthdayNFTDeployScript is Script, Test {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        // Deploy the Mona2024BirthdayNFT contract
        Mona2024BirthdayNFT nft = new Mona2024BirthdayNFT();

        vm.stopBroadcast(); 

        // Check the initial owner of the NFT
        assertEq(nft.ownerOf(0), address(0x2aF8DDAb77A7c90a38CF26F29763365D0028cfEf), "NFT should be initially owned by Mona's address");

        // Get the name of the token
        string memory name = nft.name();

        // Check if the name is not empty
        assertEq(name, "Mona 2024 Birthday NFT", "Token name does not match expected.");

        // Get the symbol of the token
        string memory symbol = nft.symbol();

        // Check if the symbol is not empty
        assertEq(symbol, "MB2024", "Token symbol does not match expected.");
    }
}
