
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {ERC721} from "@/solady/tokens/ERC721.sol";

contract Mona2024BirthdayNFT is ERC721 {
    function name() public view virtual override returns (string memory) {
        return "Mona 20204 Birthday NFT";
    }

    function symbol() public view virtual override returns (string memory) {
        return "2024";
    }

    function tokenURI(uint256 id) public view virtual override returns (string memory) {
        if (!_exists(id)) revert TokenDoesNotExist();
    }
}
