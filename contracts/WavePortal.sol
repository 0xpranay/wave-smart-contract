//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    mapping(address => uint) public wavesPerAddress;

    constructor() {
        console.log("A contract is smart, a group of degens aren't");
    }

    function wave() public {
        totalWaves += 1;
        wavesPerAddress[msg.sender] += 1;
        console.log("%s has waved, it's his wave #%d!", msg.sender, wavesPerAddress[msg.sender]);
        if(wavesPerAddress[msg.sender] == 1)
        {
            console.log("It's your first wave, Welcome!");
        }
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}