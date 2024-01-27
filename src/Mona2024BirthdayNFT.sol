
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {ERC721} from "@/solady/tokens/ERC721.sol";

contract Mona2024BirthdayNFT is ERC721 {
    address immutable public MONA_ADDRESS = address(0x2aF8DDAb77A7c90a38CF26F29763365D0028cfEf);

    constructor() {
        _mint(address(MONA_ADDRESS), 0);
    }

    function deposit() external payable {}

    function name() public view virtual override returns (string memory) {
        return "Mona 20204 Birthday NFT";
    }

    function symbol() public view virtual override returns (string memory) {
        return "MB2024";
    }

    function tokenURI(uint256 id) public view virtual override returns (string memory) {
        if (!_exists(id)) revert TokenDoesNotExist();
    }

    function withdraw(uint256 amount) public {
        require(ownerOf(0) == msg.sender, "Only the owner of the NFT can withdraw");
        require(address(this).balance >= amount, "Not enough funds");

        payable(msg.sender).call{value: amount}("");
    }
}
