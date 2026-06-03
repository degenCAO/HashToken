// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {HashToken} from "src/ERC20HashToken.sol";
import {Deploy} from "script/Deploy.s.sol";
import {Test} from "lib/forge-std/src/Test.sol";
import {StdInvariant} from "lib/forge-std/src/StdInvariant.sol";

contract TestMintHashToken is StdInvariant, Test {
    HashToken public hashToken;
    uint256 public tokenPerMint;
    Deploy deploy = new Deploy();

    function setUp() public {
        tokenPerMint = 10e18;

        //tests for zero value arrays
    }

    function testDoesntPremintWithZero() public {
        uint256[] memory values = new uint256[](0);
        address[] memory addresses = new address[](0);

        //this setup gives roughly 18-19% chance on successful call,mainly because block.prevrandao and block.timestamp are constants.
        //Or at least thats how I see it.
        hashToken = deploy.run("HashToken", "HSH", tokenPerMint, 1 days, 0, 1, values, addresses);
        assertEq(hashToken.totalSupply(), 0);
    }

    function testDeploymentRevertsIfLengthIsDiffirent() public {
        uint256[] memory values = new uint256[](0);
        address[] memory addresses = new address[](1);

        vm.expectRevert();

        //this setup gives roughly 18-19% chance on successful call,mainly because block.prevrandao and block.timestamp are constants.
        //Or at least thats how I see it.
        hashToken = deploy.run("HashToken", "HSH", tokenPerMint, 1 days, 0, 1, values, addresses);
    }

    function testPremintWorks() public {
        uint256[] memory values = new uint256[](2);
        address[] memory addresses = new address[](2);
        values[0] = 10e18;
        values[1] = 10e18;
        addresses[0] = makeAddr("User one");
        addresses[1] = makeAddr("User two");

        //this setup gives roughly 18-19% chance on successful call,mainly because block.prevrandao and block.timestamp are constants.
        //Or at least thats how I see it.
        hashToken = deploy.run("HashToken", "HSH", tokenPerMint, 1 days, 0, 1, values, addresses);
        assertEq(hashToken.balanceOf(addresses[0]), values[0]);
        assertEq(hashToken.balanceOf(addresses[1]), values[1]);
    }
}
