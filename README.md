# Merkle Airdrop Smart Contract

This project consists of two Solidity smart contracts:

1.  MerkleAirdrop.sol – A contract that facilitates token airdrops using a Merkle tree for efficient verification of claim eligibility. It integrates EIP-712 signatures for additional security. Users can claim their allocated tokens by providing a valid Merkle proof and signature.

2.  BagelToken.sol – An ERC-20 token contract for "Bagel Token" (BT). It allows the contract owner to mint tokens, which can then be distributed via the Merkle Airdrop contract.

## Features:

- Merkle Proof Verification: Ensures only eligible users can claim tokens.
- EIP-712 Signature Authentication: Prevents unauthorized claims.
- Claim Tracking: Prevents duplicate claims.
- Secure Token Transfers: Uses OpenZeppelin’s SafeERC20 for secure token distribution.

# Getting Started

### Setup anvil and deploy contracts

Swap back to vanilla foundry and run an anvil node:

```bash
foundryup
make anvil
make deploy
# Copy the BagelToken address & Airdrop contract address
```

Copy the Bagel Token and Aidrop contract addresses and paste them into the `AIRDROP_ADDRESS` and `TOKEN_ADDRESS` variables in the `MakeFile`

The following steps allow the second default anvil address (`0x70997970C51812dc3A010C7d01b50e0d17dc79C8`) to call claim and pay for the gas on behalf of the first default anvil address (`0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266`) which will recieve the airdrop.

### Sign your airdrop claim

```bash
# in another terminal
make sign
```

Retrieve the signature bytes outputted to the terminal and add them to `Interact.s.sol` _making sure to remove the `0x` prefix_.

Additionally, if you have modified the claiming addresses in the merkle tree, you will need to update the proofs in this file too (which you can get from `output.json`)

### Claim your airdrop

Then run the following command:

```bash
make claim
```

### Check claim amount

Then, check the claiming address balance has increased by running

```bash
make balance
```

NOTE: `0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266` is the default anvil address which has recieved the airdropped tokens.

## Testing

```bash
foundryup
forge test
```

### Test Coverage

```bash
forge coverage
```

## Estimate gas

You can estimate how much gas things cost by running:

```
forge snapshot
```

And you'll see an output file called `.gas-snapshot`

# Formatting

To run code formatting:

```
forge fmt
```

[![David Korgalidze Linkedin](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/dato-korgalidze/)

DAVID KORGALIDZE
