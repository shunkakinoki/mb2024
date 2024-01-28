// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Mona2024BirthdayNFT} from "../src/Mona2024BirthdayNFT.sol";

contract Mona2024BirthdayNFTTest is Test {
    Mona2024BirthdayNFT nft;

    function setUp() public {
        // Deploy the Mona2024BirthdayNFT contract
        nft = new Mona2024BirthdayNFT();
    }

    function testNFTOwner() public {
        // Check the initial owner of the NFT
        assertEq(nft.ownerOf(0), address(0x2aF8DDAb77A7c90a38CF26F29763365D0028cfEf), "NFT should be initially owned by Mona's address");
    }

    function testName() public {
        // Get the name of the token
        string memory name = nft.name();
        
        // Check if the name is not empty
        assertEq(name, "Mona 2024 Birthday NFT", "Token name does not match expected.");
    }

    function testSymbol() public {
        // Get the symbol of the token
        string memory symbol = nft.symbol();
        
        // Check if the symbol is not empty
        assertEq(symbol, "MB2024", "Token symbol does not match expected.");
    }

    function testDescription() public {
        // Get the description of the token
        string memory description = nft.description();
        
        // Check if the description is not empty
        assertTrue(bytes(description).length> 0, "Token description does not match expected.");
    }

    function testDeposit() public {
        // Check the initial balance of the contract
        uint initialBalance = address(this).balance;
        
        // Deposit 1 Ether
        nft.deposit{value: 1 ether}();
        
        // Check the new balance of the contract after depositing
        assertEq(address(this).balance, initialBalance - 1 ether, "balance should decrease by 1 ether after depositing");
        assertEq(address(nft).balance, 1 ether, "balance of address(this) should be 1 ether");
    }

    function testFailedWithdraw() public {
        // Deposit 1 Ether
        nft.deposit{value: 1 ether}();

        // Try to withdraw 1 Ether
        // vm.expectRevert();
        nft.withdraw(1 ether);

        // Check the new balance of the contract after withdrawal
        assertEq(address(nft).balance, 1, "Contract balance should be 1 after the attempted withdrawal");
    }

    function testWithdrawByMona() public {
        // Deposit 1 Ether
        nft.deposit{value: 1 ether}();

        // Check that the withdrawal fails before the target date
        vm.expectRevert();
        vm.prank(address(0x2aF8DDAb77A7c90a38CF26F29763365D0028cfEf));
        nft.withdraw(1 ether);

        // Warp to the target date
        vm.warp(1724495062);

        // Prank Mona's address to make Mona appear as the transaction sender, then withdraw 1 Ether
        vm.prank(address(0x2aF8DDAb77A7c90a38CF26F29763365D0028cfEf));
        nft.withdraw(1 ether);

        // Check the new balance of the contract after withdrawal
        assertEq(address(nft).balance, 0, "Contract balance should be 0 after the withdrawal");

        // Check the new balance of Mona's address after withdrawal
        assertEq(address(0x2aF8DDAb77A7c90a38CF26F29763365D0028cfEf).balance, 1 ether, "Mona's balance should be 1 ether after the withdrawal");
    }

    function testMultipleDepositsAndCumulativeWithdrawals() public {
        // Deposit 1 Ether three times
        nft.deposit{value: 1 ether}();
        nft.deposit{value: 1 ether}();
        nft.deposit{value: 1 ether}();

        // Check the new balance of the contract after deposits
        assertEq(address(nft).balance, 3 ether, "Contract balance should be 3 ether after the deposits");

        // Prank Mona's address to make Mona appear as the transaction sender, then withdraw 2 Ether       
        vm.prank(address(0x2aF8DDAb77A7c90a38CF26F29763365D0028cfEf));
        nft.withdraw(2 ether);

        // Check the new balance of the contract after withdrawal
        assertEq(address(nft).balance, 1 ether, "Contract balance should be 1 ether after the withdrawal");
    }
}
