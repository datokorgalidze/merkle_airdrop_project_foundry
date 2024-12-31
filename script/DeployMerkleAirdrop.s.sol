// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import { MerkleAirdrop } from "../src/MerkleAirdrop.sol";
import { Script } from "forge-std/Script.sol";
import { BagelToken } from "../src/BagelToken.sol";
import { console } from "forge-std/console.sol";
import { IERC20  } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";



contract DeployMerkleAirdrop is Script {
     bytes32 public ROOT = 0x32b990ecb7af9d52eaf80ea29f3e73b36ef9f12682e404e8b73be87e595f225d;
     uint256 public AMOUNT_TO_SEND = 4 * (25 * 1e18);

     
     function deployMerkleAirdrop () public returns (MerkleAirdrop, BagelToken) {
           vm.startBroadcast();

           BagelToken bagelToken = new BagelToken();
           MerkleAirdrop airDrop = new MerkleAirdrop(ROOT, IERC20(bagelToken));
           bagelToken.mint(bagelToken.owner(), AMOUNT_TO_SEND );
           IERC20(bagelToken).transfer(address(airDrop), AMOUNT_TO_SEND);
           vm.stopBroadcast();
           return (airDrop, bagelToken);
     }


     function run () external returns ( MerkleAirdrop, BagelToken ){
         return deployMerkleAirdrop();
     }
}