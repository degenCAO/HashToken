// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {HashToken} from "src/ERC20HashToken.sol";
import {Script} from "lib/forge-std/src/Script.sol";

contract Deployer is Script {
    function run(
        string memory name,
        string memory symbol,
        uint256 tokensPerMint,
        uint256 miningTime,
        uint256 initialTarget,
        uint256 difficultyAdjustment
    ) external returns (HashToken) {
        deploy(name, symbol, tokensPerMint, miningTime, initialTarget, difficultyAdjustment);
    }

    function deploy(
        string memory name,
        string memory symbol,
        uint256 tokensPerMint,
        uint256 miningTime,
        uint256 initialTarget,
        uint256 difficultyAdjustment
    ) public returns (HashToken) {
        vm.startBroadcast();
        HashToken hashToken =
            new HashToken(name, symbol, tokensPerMint, miningTime, initialTarget, difficultyAdjustment);
        vm.stopBroadcast();
        return hashToken;
    }
}
