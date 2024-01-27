
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {ERC721} from "@/solady/tokens/ERC721.sol";

contract Mona2024BirthdayNFT is ERC721 {
    // -------------------------------------------------------------------------
    // Immutable
    // -------------------------------------------------------------------------

    /// @dev Mona's address (tomona.eth)
    /// @notice This address is the owner of the token id 0.
    address immutable public MONA_ADDRESS = address(0x2aF8DDAb77A7c90a38CF26F29763365D0028cfEf);

    // -------------------------------------------------------------------------
    // Error
    // -------------------------------------------------------------------------

    /// @dev Error thrown when the token does not exist (ERC721)
    /// @notice This error is thrown when the token does not exist.
    /// @notice However, this contract only has one token, so this error is never thrown.
    error NotMona();
    /// @dev Error thrown when the token does not exist (ERC721)
    /// @notice This error is thrown when the balance of the contract is insufficient.
    /// @notice The amount of funds is equal to the amount in this contract.
    error InsufficientFunds(uint256 requested, uint256 available);

    // -------------------------------------------------------------------------
    // Constructor
    // -------------------------------------------------------------------------

    /// @dev Constructor
    /// @notice This constructor mints a token with id 0 to the address of Mona.
    constructor() {
        _mint(address(MONA_ADDRESS), 0);
    }

    // -------------------------------------------------------------------------
    // Fallback
    // -------------------------------------------------------------------------

    /// @dev Fallback
    /// @notice This fallback function is used to receive funds.
    function deposit() external payable {}

    // -------------------------------------------------------------------------
    // Public
    // -------------------------------------------------------------------------

    /// @dev Returns the name of the token (ERC721)
    /// @notice This function returns the name of the token.
    function name() public view virtual override returns (string memory) {
        return "Mona 20204 Birthday NFT";
    }

    /// @dev Returns the symbol of the token (ERC721)
    /// @notice This function returns the symbol of the token.
    function symbol() public view virtual override returns (string memory) {
        return "MB2024";
    }

    /// @dev Returns the URI of the token (ERC721)
    /// @notice This function returns the URI of the token.
    function tokenURI(uint256 id) public view virtual override returns (string memory) {
        if (!_exists(id)) revert TokenDoesNotExist();
    }

    /// @dev Withdraws funds from the contract
    /// @notice This function withdraws funds from the contract.
    function withdraw(uint256 amount) public {
        if (ownerOf(0) != msg.sender) {
            revert NotMona();
        }

        if (address(this).balance < amount) {
            revert InsufficientFunds(amount, address(this).balance);
        }

        payable(msg.sender).call{value: amount}("");
    }
}
