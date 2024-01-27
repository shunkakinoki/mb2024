
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Base64} from "@/solady/utils/Base64.sol";
import {ERC721} from "@/solady/tokens/ERC721.sol";

/// @title Mona 2024 Birthday NFT
/// @author Shun Kakinoki(@shunkakinoki)
/// @author fiveoutofnine (Did mostly all of the heavy lifting - truly thankful for your dedication to craft)
/// @dev Mona 2024 Birthday NFT
/// @notice This contract is an ERC721 contract that mints a token with id 0 to the address of Mona.
/// @notice This contract also has a function to receive funds and a function to withdraw funds.
contract Mona2024BirthdayNFT is ERC721 {
    // -------------------------------------------------------------------------
    // Constants
    // -------------------------------------------------------------------------

    /// @notice Description of the collection.
    /// @notice This description is used in the metadata of the token.
    string constant COLLECTION_DESCRIPTION =
        unicode"Celebrating three epic years with Mona, an icon of innovation and imagination.\n"
        unicode"As we mark 2024, we reflect on her remarkable journey filled with endeavors that inspire us all.\n"
        unicode"Here's to Mona, to her   may her creative spirit continue to shape our future. Happy Birthday!";

    /// @dev The encoded SVG of the token.
    /// @notice The encoded SVG of the token.
    string constant ON_CHAIN_SVG = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIzMDAiIGhlaWdodD0iMTUwIiB2aWV3Qm94PSIwIDAgMzAwIDE1MCIgZmlsbD0ibm9uZSI+CiAgPHN0eWxlPgogICAgQGZvbnQtZmFjZXtmb250LWZhbWlseTpBO3NyYzp1cmwoZGF0YTpmb250L3dvZmYyO3V0Zi04O2Jhc2U2NCxkMDlHTWdBQkFBQUFBQW44QUJBQUFBQUFFUVFBQUFtbEFBRUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBR2g0YklCeFdCbUFBYUJFSUNwYzhraVVMR0FBQk5nSWtBeG9FSUFXRFNBY2dGeVFZR0J0QURjaU93M1I3STh1UUpNVXJ0K0g1YmZZK2ZFSVFSWVhXWmdMcU5zekFJVlpqVkM4U3RvYXRDU3ZBYXF4emErZThyYW1yQ0I3d0wzMTMxMDFyMklvM3BZa2pQckdDNVkrWENoYXNLVkFGQzFiYlYydHFBeVJUSUJmMEZUSlRJU3RzamJuY2hmWXZSSmN2TWF2cUNsa0Z5QlpJMTZnS3E2czZmVlhUVlRaeFlrS3VuRGtWZi93NnJRUVFCSFJZRUdwdVlpRGdQQnhiOXFDbE1DRURZTUYvRW9pRE5TbDFSMEVVQVU3RS94b05BNHZUbnZjQ3BBZ3BRSnJnMGRBMENvSjFvSm5iWVppQkV6M3lORUFCaURNaUd3QVFmMW9ZZEFTa3lCWmdBallCejVPN1NuSUNFU1BvYWpHeStmOFVBRGlGSENPc0FhRnNBS0FId2dnQVIxbUZDR3lBQkJUU1ViQ01DQkdSTzRZWDgrcDQ1NHZ1MXdjYy92UnE4VUJuNVVXUm56L3ZmbjU4TU96RzYyZnNtOVFBUW9Sa0NBd0NaYUk0Uy9FSElhWEVBWUFiNExoWkYzd3FRY0pDV1FkQ2hxMFJDMHNpTVlkTnJLKzJ0SUR4a0xFVW1HaXhoMHdTNEsyc2lPWis4NUtWU1FncFlTaXBLcnhNcXk5TFZpaUFYRTZTeXdFaUtNZ3lrNGs5TnNaVURhQ0txaUxMZTkxQXpuenRPaEJ2K3FqMWVtT3BkS04vam0weWlWUmtnMEd2YjFKdk1QcU54akFsMVdBd09QVnRWcXBYR0l0R2tWSkZsUmtNZG4zekpmMkxHMzVrYzd3TVF1SWswZ2NzK3kwRDVNSlVWYzgybTZ4WVgvZGhNVWtPT3dGRDVwVEp4RlNwcUJJT2U2U0w1UlFKVHBtUS9VUWZZd2pGNmllYk5DTWVJZ0ppQXdqeitsS2xrbnJiaEcxY2NKSUhMSHZ0Vm9reUZYWm9hOU5qclRyNUNtWFcySGp0YllPQjNqV2ZDdE1JVUR1T2gzQkFyRjdHU1NISmlBbVNERk9VZWo3dERwblFQU0pOam5ob3FDL3REaXpGeEFSWkljZVpnMEdZUEltNHBkSXRBVnk2dUhCUnBSTHFIM1pUVXV2elNmcnJ3TEtUZHZyVW9CUnV6b2tuU25FS2pWYkQ0NkhQSFgvQ2FTTGw5V1BMOEtxUkVhWktRc1ZwWDRMUW1aT1NUVkhsR1lvaENDZkM3NFNabGxPdFREbEZPYnZZZEM2Vm5ZV3NvbWlVSkZrV1Q5aWoxZXlRRloxZEFSQXJ5SytaVEh0SHlEY3cwbkZ6SjV4NEk5U0tPOE5BM0FkVU0vNEtpdkpFOVJwTCs1VGVOYzFTcjFBV2pVRmQwbGtxS1g2aGora3lyRTh5bWFMbDA0TTBjNm5SYUQvKzRzNG8yNHRFNm4zRTBHTEcxdGJNY0tySENGcEd5T0pJL3kraDNtQU1HNE9VVkkxaDV5NElteFdxbnFWWW1nYzBXMlZ2a2x4SVlqTFYwMHhGMXR4Y3NPM1ZZeklRNkFvVnRXZkpxRzF5MnN5MnM0L2UxVnRtTk0vbG9sS1Fod3g0V2RZcVY5TTN6VnJXNXo0d2VxbFU1SzR0azRtdDBuSW5lbjNVK2hKamRhV1pNdTJ1L3N2TlI1Z2ovUlNsbEtTa1RobTQ2eDZkZzdaeURWNW1jaC9ML3hKcS9VUFhVU0EyMkcwWkFqVUx0TTVsMXcxam5GNHZXbjN1OExydzRSb1E3NVI4MUNKeHlwNjNNdTdCcUVjZStFeXBjZTdHeXloeUtyMCtVcVpiMVZjNDZRc1FYaDdoLytHSEFraC8yYjFUdnV6SFltSHg3YitldWQ0Y2lNR2NLZjZ3ejNLSDhPWVBOQ0VRWmdVdzRXVGMyOStQVTdmck1OeHdMaFozVUQ3RW9WaG5hUXV3ZFlnaXlIWEZQckdIZVR6S3pmTWNsQ0lkcDhlaEw5bzFoL0kvU3N2b3lCOXdMUXZNYmJGL3lTZTFSOGNWdVpFWkNTZjllelRkcWNVQzVxNWcvcjREZHVtQms2UFhRSDlNY3FwUjdvUDNPbWpQL1BRR2NLcGMzeUFMSVhEU1BJWTE0cHVqMDZWRXJtZ1krbFNuUDJ3WlJWNEpYRmVCUSt3VnFnY2E1ZXg5Y3FUVjBLNlY1eVBQcGdEb3VuQXV0RGJKM0QrK3A3MWc5N2JmOGVWWXYvb0J3WnBGYm80RVBXekRuZUR2bXFhbjVwQitpYS8zUCs1eU1yY1M4TzZyNmFrZ3J5U012dXlYL2VyKzBxZHZLTjJadzBzOUliU3F1dkh6UjEvMWYyRTk5eWd0ZHNmSFBaSlZnb214Ky9ZL1Q3RGNMaDUvVUxkUmlQcnVtc3d6ZU56M2p5Z01HcHFERVBIOG5EbWtTR2ZQeGUrdFA2OHlEMkF0N2FyVjMyOXVXUm1sNngzNVZoMjVGbFlrZndZYTE4ZGErWEtuV3BTTXNSZDlSTXp4L2ZSWEYrbkRGWTkvcTdPU01MQUQzZVBDUU8rcGRCZzRWVWlPVGUzZTdaT0FSZjlYQ2lQZGdGTlBtTTk1WUdzYjZSZmc0bHVNYi92a3pEV2RIZUZETDJ1UGFXSk9WckZRK2xEejExdlZXV0hZN3gxWDNiWjVhUXc2Vm56OWZOZjMxNWJqY253LytkVEZlME1JTmJkR090QTh6dloyUzFMcmVUYUJ3L25Rd1ZFV2pFVis5NVduaDlXWFIxZlBFbk9pQzZPTFA4QXlhT2pUZjl1ZFNUdnpkK3JwdElzZzFaMXlPdnpPNE5oYWsxTjM4Mm9CeThZbVlyU1V6a0ZpVUdZcHhlRE8wb1l2Qk56enZyNUx3cXdsdjltL3pxRFZhVTd0aVFRZGpJVzcwMktqMHc4NlcrS2VuaVBSS0dpbXJUMmJ6WGFOakl4WS9PQ25sZmZ4MGFSaFZzNzkrMFVSb3hyMEE2SW44WE9hT2RrS0c3UlJuc0htU0NMbUg3aCttSlUzM3BSWFNlV0lUcWlqb2s4VEhHeFJ1Smx6SkNvWmJlbGdOeVFSR244cm9PUmx6Y0FxTTlGVTR5Y1VaVkxaWGwvaEtRaWVuNnprb1BDako0VExrbVR5UmZ5Z3lDNlQ1K2ZuUXNaYVpHYmR1MmRuL3BKb3cwMnlxSWtPOGowOHFsaWR5QmFHb0EyWlIwWDkrNzVkTFVyQ3dMWmtUdXZSeGxnVWNLcGNlL2hQd3o5ZlYreHpFbDUzVHR0TTB2MHN0SHFlN3VvbytpaW05dDhUS1FRMGpZeEpFSGhoQUxYOHg3bjNQM1J1SzB5aW42YTNlWkVTOGgxMEp6YTBSQ0l0MGo2R2t1WHZmWkU3eEU3eHllWVhQb2gzSjhaWTU4VnltbFd0Mm5oS0hNaWJPQmRON1J0a3VTZTdKV2ZIa2RpNnBPMDAwMlFsMXUvbkYvSEJ6V2dGLzhlM0V0RHh4UFZQUktENjVmWkdNZzVVMVJJUnhWRVJ3UldoQ1JEMTQxSUt1Z1JadGNmVERBV3QvY3kzVEZtVDNrMkhmOTk1NTk1SmlnWFdoaGxudjlqNHdYdmI2ajgrRjRJL28xR0VHdkpaMmJkMXUyd3VkVzYyMTN2UVJONG9iSFNOb0xCZ1hoWXdMM2JjcEZQekFXbk0zM2ZwUFVGTzBtanhWZWNDYXF6N2xCUG5JUERiK1BFaW45TG5KbWxTQmpkbFh3QlBCRzVSWEc2VW0vc09uUkNBNEtad2QwTW1lNVFyNVd5anVKenVRdUI1TVVzakVoZ3RKOUJJSzhlNDQyakxjUTdkZmtjZUJ3V3cvZDZUaFNMTGtGK3hlT1FYS3VrdFJUci9MdURkbTNMYS8vNy9mUXJEeUMwQW9DRlVDWURUL3o3UXRtYUM4RitqNlFVNXhPL0dHeUtmWU1nRkQ4c1ZzQTdDNDZ2QU94Wm5XeVkrUGdYSUZrQWhpcVFSak55TEoyTVc0dTRBZWdqSEhUMkNoUy8wU0VGK0d3NG42MUVZRWU5cGFLd29EdXpUcE5raHJXcFVxZGJPa1JmZURqd3RaRVNFRlpCN2dNYWdUbGF2SEJJenNrWmxRZGpFVXJRYXFFMm1aVVVaWDRmQlBPS2dqVkpPbFNoQU0yRkI5bTc0S2pXSktFdEpxVDNLQW0xZzBBbWFvS1JlaGNvTE5DWkRHMGNQTnh5elc5UHdCcGdJdDFNUXlVQUpZWFhTc3ZCVk91aGRXM25hd3hjUFQ3QmNVWkk0Q2E2R1FFOHczQzBVNFFIUm1xNE5jN1FETCtoRHdqVC9QNEtrTmxRRzBQOC84N2ZJc3Y2ZityOGdJd1BnaldDRDJEckladUJ0ajRUYm5RRVY4UndReG1MZ0RRQUEpfQogICAgdGV4dC5he2ZvbnQtZmFtaWx5OkE7ZmlsbDojZmZmO2ZvbnQtc2l6ZTo1MHB4O2xpbmUtaGVpZ2h0OjE7ZG9taW5hbnQtYmFzZWxpbmU6aGFuZ2luZztsZXR0ZXItc3BhY2luZzoxcHh9CiAgPC9zdHlsZT4KICA8cGF0aCBmaWxsPSIjMDAwIiBkPSJNMCAwaDUxMnY1MTJIMHoiLz4KICA8dGV4dCBjbGFzcz0iYSI+56ulPC90ZXh0PgogIDx0ZXh0IGNsYXNzPSJhIiB5PSI1MCI+5b+DPC90ZXh0PgogIDx0ZXh0IGNsYXNzPSJhIiB5PSIxMDAiPuOCiOOAgeawuOmBoOOBq+OAgjwvdGV4dD4KPC9zdmc+";
      
    /// @dev Name of the token
    /// @notice This name is used in the metadata of the token.
    string constant NFT_NAME = "Mona 2024 Birthday NFT";

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
    /// @dev Failure to withdraw funds
    /// @notice This error is thrown when the withdrawal of funds fails.
    error WithdrawalFailed();

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
        return NFT_NAME;
    }

    /// @dev Returns the symbol of the token (ERC721)
    /// @notice This function returns the symbol of the token.
    function symbol() public view virtual override returns (string memory) {
        return "MB2024";
    }

    /// @dev Returns the description of the collection
    /// @notice This function returns the description of the collection.
    function description() public pure returns (string memory) {
        return COLLECTION_DESCRIPTION;
    }

    /// @dev Returns the URI of the token (ERC721)
    /// @notice This function returns the URI of the token.
    function tokenURI(uint256 id) public view virtual override returns (string memory) {
        // If the token does not exist, throw an error
        if (!_exists(id)) {
            revert TokenDoesNotExist();
        }

        // Concatenate the SVG and the JSON
        return
            string.concat(
                "data:application/json;base64,",
                Base64.encode(
                    abi.encodePacked(
                        '{"name":"',
                        NFT_NAME,
                        '","description":"',
                        COLLECTION_DESCRIPTION,
                        '","image_data":',
                        ON_CHAIN_SVG,
                        "}"
                    )
                )
            );
    }

    /// @dev Withdraws funds from the contract
    /// @notice This function withdraws funds from the contract.
    /// @notice Only Mona can call this function.
    /// @notice The target amount of the funds is 0.3 ETH.
    function withdraw(uint256 amount) public {
        // Throws if the caller is not Mona
        if (ownerOf(0) != msg.sender) {
            revert NotMona();
        }

        // Throws if the balance of the contract is insufficient
        // The amount of funds is equal to the amount in this contract
        if (address(this).balance < amount) {
            revert InsufficientFunds(amount, address(this).balance);
        }

        // Send funds to Mona
        (bool sent,) = payable(msg.sender).call{value: amount}("");

        // Throws if the withdrawal of funds fails
        if (!sent) {
            revert WithdrawalFailed();
        }
    }
}
