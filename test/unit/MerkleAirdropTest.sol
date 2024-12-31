
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MerkleAirdrop} from "../../src/MerkleAirdrop.sol";
import {BagelToken} from "../../src/BagelToken.sol";
import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import { ZkSyncChainChecker } from "foundry-devops/src/ZkSyncChainChecker.sol";
import { DeployMerkleAirdrop } from "../../script/DeployMerkleAirdrop.s.sol";


contract MerkleAirdropTest is ZkSyncChainChecker, Test {
    MerkleAirdrop airdrop;
    BagelToken token;

    
    bytes32 ROOT = 0x32b990ecb7af9d52eaf80ea29f3e73b36ef9f12682e404e8b73be87e595f225d;
    uint256 public amount = (25 * 1e18);
    uint256 public amountToSend = amount * 4;
    bytes32 proofOne = 0x525e0923322e9f16b5443d891e7f782883f0ed2578ec7d4bb5300da0a5e2716b;
    bytes32 proofTwo = 0x0b2a6776cb9c3768674bb6fe77eb91b07c02bed59390c366a64a0e3ee4f1f321;
    bytes32[] public PROOF = [proofOne, proofTwo];


    address user ;
    uint256 userPriveteKey;
    address gasPayer;

     function setUp () public {
         if ( !isZkSyncChain() ) {
            DeployMerkleAirdrop deployer = new DeployMerkleAirdrop();
            (airdrop, token ) = deployer.deployMerkleAirdrop();            
         }else{
            token = new BagelToken();
            airdrop = new MerkleAirdrop( ROOT, token);
            token.mint(token.owner(),amountToSend );
            token.transfer(address(airdrop), amountToSend);
         }
         (user, userPriveteKey) = makeAddrAndKey("user");
         gasPayer = makeAddr("gasPayer");
        
     }


     function testUsersCanClaim () public  {
        // console.log("user address:", user);
        uint256 startingBalane = token.balanceOf(user);
        bytes32 digest = airdrop.getMassageHash(user, amount);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(userPriveteKey, digest);

        vm.prank(gasPayer);
        airdrop.claim(user,amount, PROOF, v, r, s);
        uint256 endingBalance = token.balanceOf(user);
         console.log(endingBalance);
        assertEq(endingBalance - startingBalane, amount );
    }
}






