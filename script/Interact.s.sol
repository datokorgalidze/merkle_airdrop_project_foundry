// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;



import { Script, console } from "forge-std/Script.sol";
import { DevOpsTools } from "foundry-devops/src/DevOpsTools.sol";
import { MerkleAirdrop } from "../src/MerkleAirdrop.sol";




contract ClaimAirdrop is Script {

    address claimngAddress = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
    bytes32 ROOT = 0x32b990ecb7af9d52eaf80ea29f3e73b36ef9f12682e404e8b73be87e595f225d;
    uint256 public amount = (25 * 1e18);
    bytes32 proofOne = 0x147217ca13a7aa6cb62fcdc405bf09fe5acdcab0765502450274ed81ccebd1df;
    bytes32 proofTwo = 0x85d455c90d5ba3d56aac0dfc65ea22e07433818b08af85dc44215371dd289445;
    bytes32[] public PROOF = [proofOne, proofTwo];
    bytes private SIGNATURE = hex"a45ce73ff1cd24b9b9a4b7f32276e4fe7c3c6371a359b87cdf4556ca3c15e25d2f29303f1fef50a6c426f6dad756f0922519b03359d5760473c006657801f1041c";
    

    error  __ClaimAirdropScript__InvalidSignatureLength();

function claimAirdrop (address airdrop) public {
       vm.startBroadcast();
       (uint8 v, bytes32 r, bytes32 s) = splitSignature(SIGNATURE);
       MerkleAirdrop(airdrop).claim(claimngAddress,amount,PROOF, v, r, s);
       vm.stopBroadcast();
}


function splitSignature (bytes memory signature) public pure returns (uint8 v, bytes32 r, bytes32 s){
            if (signature.length != 65) {
            revert __ClaimAirdropScript__InvalidSignatureLength();
        }
        assembly {
            r := mload(add(signature, 32))
            s := mload(add(signature, 64))
            v := byte(0, mload(add(signature, 96)))
        }
}

function run () external {
    address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("MerkleAirdrop", block.chainid);
    claimAirdrop(mostRecentlyDeployed);
    }
}