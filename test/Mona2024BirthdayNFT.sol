// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Mona2024BirthdayNFT} from "../src/Mona2024BirthdayNFT.sol";

contract Mona2024BirthdayNFTTest is Test {
    Mona2024BirthdayNFT nft;

    function setUp() public {
        nft = new Mona2024BirthdayNFT();
    }

    function testInitialNFTOwner() public {
        assertEq(nft.ownerOf(0), address(0x2aF8DDAb77A7c90a38CF26F29763365D0028cfEf), "NFT should be initially owned by Mona's address");
    }

    function testTokenName() public {
        string memory name = nft.name();
        assertEq(name, "Mona 2024 Birthday NFT", "Token name does not match expected.");
    }

    function testTokenSymbol() public {
        string memory symbol = nft.symbol();
        assertEq(symbol, "MB2024", "Token symbol does not match expected.");
    }

    function testTokenDescription() public {
        string memory description = nft.description();
        // Replace with actual expected description
        assertTrue(bytes(description).length> 0, "Token description does not match expected.");
    }

    function testDeposit() public {
        uint initialBalance = address(this).balance;
        nft.deposit{value: 1 ether}();
        assertEq(address(this).balance, initialBalance - 1 ether, "balance should decrease by 1 ether after depositing");
        assertEq(address(nft).balance, 1 ether, "balance of address(this) should be 1 ether");
    }

    function testFailedWithdraw() public {
        // vm.expectRevert();
        nft.withdraw(1 ether);
    }

    function testWithdrawByMona() public {
        nft.deposit{value: 1 ether}();
        vm.prank(address(0x2aF8DDAb77A7c90a38CF26F29763365D0028cfEf));
        nft.withdraw(1 ether);
    }

    function testMultipleDepositsAndCumulativeWithdrawals() public {
        uint initialBalance = address(this).balance;

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
