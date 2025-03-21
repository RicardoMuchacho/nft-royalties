// SPDX-License-Identifier: MIT

pragma solidity >= 0.8.24;

import {Script} from "forge-std/Script.sol";
import {NftRoyalties} from "../src/NftRoyalties.sol";

contract MintNftRoyaltiesScript is Script {
    function run() external {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        address nftContract = vm.envAddress("NFT_CONTRACT");
        vm.startBroadcast(privateKey);

        NftRoyalties nftCollection = NftRoyalties(nftContract);

        nftCollection.mint{value: nftCollection.mintPrice()}();
        vm.stopBroadcast();
    }
}
