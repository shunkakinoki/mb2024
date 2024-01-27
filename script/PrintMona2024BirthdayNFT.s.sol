// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {Mona2024BirthdayNFT} from "../src/Mona2024BirthdayNFT.sol";

/// Adopted from: https://github.com/fiveoutofnine/adopt-a-hyphen/blob/52b5730d5043d8e0afbf8adc2f69cc0700ad7e4a/script/PrintAdoptAHyphenScript.s.sol
/// License: MIT
/// Author: fiveoutofnine (thank you again!)

/// @title A script to print the token URI returned by `Mona2024BirthdayNFT` for
/// @notice A script to print the token URI returned by `Mona2024BirthdayNFT` for
/// testing purposes.
contract PrintMona2024BirthdayNFTScript is Script {
    /// @notice The instance of `Mona2024BirthdayNFT` that will be deployed after the
    /// script runs.
    Mona2024BirthdayNFT internal nft;

    /// @notice Deploys an instance of `Mona2024BirthdayNFT` and mints token #0.
    function setUp() public {
        // Deploy the Mona2024BirthdayNFT contract
        nft = new Mona2024BirthdayNFT();
    }

    /// @notice Prints the token URI for token #0.
    function run() public view {
        console.log(nft.tokenURI(0));
    }
}
