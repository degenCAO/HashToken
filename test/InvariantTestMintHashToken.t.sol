// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {HashToken} from "src/ERC20HashToken.sol";
import {Deploy} from "script/Deploy.s.sol";
import {Test} from "lib/forge-std/src/Test.sol";
import {StdInvariant} from "lib/forge-std/src/StdInvariant.sol";

contract TestMintHashToken is StdInvariant, Test {
    HashToken public hashToken;
    uint256 public tokenPerMint;

    function setUp() public {
        tokenPerMint = 10e18;

        Deploy deploy = new Deploy();

        //this setup gives roughly 18-19% chance on successful call,mainly because block.prevrandao and block.timestamp are constants.
        //Or at least thats how I see it.
        hashToken = deploy.run("HashToken", "HSH", tokenPerMint, 1 days, 0, 1);
        targetContract(address(hashToken));

        //only call mint function
        bytes4[] memory selector = new bytes4[](1);
        selector[0] = HashToken.mint.selector;

        targetSelector(FuzzSelector({addr: address(hashToken), selectors: selector}));
    }

    //fuzz test for mining
    function invariant_testFuzzCanCallMintFunction() public {
        assert(true);
    }
}
