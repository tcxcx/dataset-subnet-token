// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";


import {MerkleInterchainModel} from "./MerkleInterchainModel.sol";
import {MessageDispatchHook} from "./MessageDispatchHook.sol";
import {PostOffice} from "./PostOffice.sol";

interface ISpecifiesInterchainSecurityModule {
    function interchainSecurityModule()
        external
        view
        returns (MerkleInterchainModel);
}

contract ActivateSubnet {
    constructor() {}

    PostOffice mailbox = PostOffice(0x2d1889fe5B092CD988972261434F7E5f26041115);

    function sendMessage(address walletAddress) public {
        uint256 fee = mailbox.quoteDispatch(
            888888,
            bytes32(uint256(0x00000000000000000000000470216b26a39578a47be085abc2aedcf037b5183)),
            abi.encode(walletAddress)
        );
        bytes32 messageId = mailbox.dispatch{value: fee}(
            888888,
            bytes32(uint256(0x00000000000000000000000470216b26a39578a47be085abc2aedcf037b5183)),
            abi.encode(walletAddress)
        );
    }
}