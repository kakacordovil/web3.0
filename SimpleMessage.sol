// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleMessage {
    // Variable for storing the message
    string public message;

    // Constructor: initialises the message when creating the contract
    constructor(string memory _initialMessage) {
        message = _initialMessage;
    }

    // Message refresh function
    function setMessage(string memory _newMessage) public {
        message = _newMessage;
    }

    // Function to read the current message
    function getMessage() public view returns (string memory) {
        return message;
    }
}
