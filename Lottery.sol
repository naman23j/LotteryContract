pragma solidity ^0.8.0;

contract Lottery {
    address[] public players;
    address public winner;

    function enter() public payable {
        require(msg.value > 0, "Send some ether to enter");
        players.push(msg.sender);
    }

    function pickWinner() public {
        require(players.length > 0, "No players in the lottery");
        uint index = random() % players.length;
        winner = players[index];
        payable(winner).transfer(address(this).balance);
        delete players;
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, players.length)));
    }
}
