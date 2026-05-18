// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {HashToken} from "src/ERC20HashToken.sol";
import {Script} from "lib/forge-std/src/Script.sol";

contract Deploy is Script {
    /*
    @param tokensPerMint - numbers of tokens per single mint
    @param miningTime - time during which minting is available
    @param initialTarget - target selected by deployer, pass 0 too be randomly selected. The higher the target - the easier is to mine.
    Do not pass arbitrary value unless you absolutely have to.
    @param difficultyAdjustment - defines how hard mining would be. Pass 0 to set it to defaul value
    By defalt it's 1 in  2 000 000(modern CPU generate 100 000 to 1 000 000 hashes per second).
    Passing 1 makes solving almost trivial(1 in 2 chance for any given value of nonce)
    */
    function run(
        string memory name,
        string memory symbol,
        uint256 tokensPerMint,
        uint256 miningTime,
        uint256 initialTarget,
        uint256 difficultyAdjustment
    ) external returns (HashToken) {
        return deploy(name, symbol, tokensPerMint, miningTime, initialTarget, difficultyAdjustment);
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
