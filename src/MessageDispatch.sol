// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity >=0.8.0;

import { MerkleInterchainModel } from "./MerkleInterchainModel.sol";
import { MessageDispatchHook } from "./MessageDispatchHook.sol";

interface PostOffice {
    
    function dispatch(
        uint32 destinationDomain,
        bytes32 recipientAddress,
        bytes calldata messageBody
    ) external payable returns (bytes32 messageId);

    function quoteDispatch(
        uint32 destinationDomain,
        bytes32 recipientAddress,
        bytes calldata messageBody
    ) external view returns (uint256 fee);

   
}