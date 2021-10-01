//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 private seed;
    uint256 totalWaves;

    mapping(address => uint256) public lastWavedAt;
    mapping(address => uint) public wavesPerAddress;

    event NewWave(address indexed from, uint256 timestamp, string message);
    event userWon(uint256 flag_number);

    struct Wave {
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    }

    Wave[] waves;

    constructor() payable {
        console.log("A contract is smart, a group of degens aren't");
    }

    function wave(string memory _message) public {


        require(
            lastWavedAt[msg.sender] + 1 minutes < block.timestamp,
            "Wait 15m"
        );

        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        wavesPerAddress[msg.sender] += 1;
        console.log("%s has waved, it's his wave #%d!", msg.sender, wavesPerAddress[msg.sender]);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        uint256 randomNumber = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %s", randomNumber);

        seed = randomNumber;

        if(seed < 80)
        {
            console.log("%s has won!", msg.sender);
            uint256 prizeAmount = 0.00001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");

            emit userWon(404);
        }

        emit NewWave(msg.sender, block.timestamp, _message);

    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256, uint256) {
        console.log("We have %d total waves!", totalWaves);
        return (totalWaves, wavesPerAddress[msg.sender]);
    }
}