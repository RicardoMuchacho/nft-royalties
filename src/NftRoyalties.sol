// SPDX-License-Identifier: MIT

pragma solidity >= 0.8.24;

import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "../lib/openzeppelin-contracts/contracts/interfaces/IERC2981.sol";
import {Strings} from "../lib/openzeppelin-contracts/contracts/utils/Strings.sol";

contract NftRoyalties is ERC721, IERC2981 {
    using Strings for uint256;

    uint256 public currentTokenId;
    string public baseUri;
    uint256 public totalSupply = 2;
    uint256 public mintPrice = 0.0001 ether;
    uint96 public royaltyFraction = 500; // 5%
    address private royaltyRecipient;

    event mintNFT(address account_, uint256 tokenId);

    modifier onlyRoyaltyRecipient() {
        require(msg.sender == royaltyRecipient, "Access Unauthorized");
        _;
    }

    constructor(string memory name_, string memory symbol_, string memory _baseUri) ERC721(name_, symbol_) {
        baseUri = _baseUri;
        royaltyRecipient = msg.sender;
    }

    function mint() external payable {
        require(currentTokenId < totalSupply, "All NFTs minted");
        require(msg.value >= mintPrice, "Not enough eth");

        uint256 returnEth = msg.value - mintPrice;

        _safeMint(msg.sender, currentTokenId);

        uint256 tokenIdMinted = currentTokenId;
        currentTokenId++;

        if (returnEth > 0) {
            (bool success,) = msg.sender.call{value: returnEth}("");
            if (!success) revert();
        }

        emit mintNFT(msg.sender, tokenIdMinted);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseUri;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        _requireOwned(tokenId);

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string.concat(baseURI, tokenId.toString(), ".json") : "";
    }

    // royaltyInfo EIP-2981
    function royaltyInfo(uint256, uint256 salePrice)
        external
        view
        override
        returns (address receiver_, uint256 royaltyAmount_)
    {
        receiver_ = royaltyRecipient;
        royaltyAmount_ = (salePrice * royaltyFraction) / 10000;
    }

    // Required override for ERC165 support
    function supportsInterface(bytes4 interfaceId) public view override(ERC721, IERC165) returns (bool) {
        return interfaceId == type(IERC2981).interfaceId || super.supportsInterface(interfaceId);
    }

    function withdrawEth() external onlyRoyaltyRecipient {
        (bool success,) = royaltyRecipient.call{value: address(this).balance}("");
        if (!success) revert();
    }
}
