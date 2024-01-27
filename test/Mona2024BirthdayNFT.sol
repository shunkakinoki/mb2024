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
        assertEq(nft.ownerOf(0), address(0x2aF8DDAb77A7c90a38CF26F29763365D0028cfEf), "NFT should be initially owned by address 1");
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
}
