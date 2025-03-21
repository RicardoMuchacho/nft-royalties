// SPDX-License-Identifier: MIT

pragma solidity >= 0.8.24;

import {Script} from "forge-std/Script.sol";
import {NftRoyalties} from "../src/NftRoyalties.sol";

contract NftRoyaltiesScript is Script {
    function run() external returns (NftRoyalties) {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        string memory name = "NFT Royalty Master";
        string memory symbol = "NFTRM";
        string memory baseUri = "ipfs://bafybeicv3s6negs4mke3uyavjfgfqpfspdfbmpkb5uo4iljwrtkpr6eluy/";
        NftRoyalties nftCollection = new NftRoyalties(name, symbol, baseUri);
        vm.stopBroadcast();

        return nftCollection;
    }
}
