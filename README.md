# 🏆 NFT Royalties Mastery

ERC721 practice repository hosting a smart contract that creates unique NFTs, which can be visualized on OpenSea and in your MetaMask wallet.

---

## 🔍 Check NFT Collection

- **Arbiscan:** [View and interact with the contract](https://sepolia.arbiscan.io/address/0xA4b3f7783E1a48A5D06df273Ba00D7F6D40B0291) on Arbiscan.
- **OpenSea:** [Browse the NFT collection](https://testnets.opensea.io/collection/nft-royalty-master) on OpenSea.
- **MetaMask:** Add the contract address to your MetaMask wallet to view your NFTs.

---

## ✨ Key Features

| **Feature**       | **Description**                                                                                        |
| ----------------- | ------------------------------------------------------------------------------------------------------ |
| Unique NFTs       | Each NFT in the "NFT Mastery" collection has unique metadata and an associated image.                  |
| IPFS Integration  | Images and JSON metadata are stored on IPFS using Pinata, ensuring decentralized and reliable storage. |
| Fast Transactions | Deployed on the Arbitrum network, enabling quick and low-cost transactions.                            |
| Verified Contract | The smart contract is verified on Arbitrum, ensuring transparency and security.                        |
| Easy Interaction  | Interact with the contract directly via Foundry or through Arbiscan.                                   |

---

## 📊 Contracts Overview

### `firstNft.sol`

This ERC721 NFT contract defines the core functionality of the NFT Mastery collection.

| **Function**                              | **Description**                                                                           |
|-------------------------------------------|--------------------------------------------------------------------------------------------|
| `constructor(string memory _name, string memory _symbol, string memory _baseUri)` | Deploys the NFT collection with a specified name, symbol, and base URI for metadata storage. |
| `mint(address _to, uint256 _tokenId)`     | Allows the contract owner to mint new NFTs and assign them to a specified address.           |                     |
| `tokenURI(uint256 _tokenId)`              | Returns the metadata URI for a given token ID by appending it to the base URI.                |
