pragma solidity ^0.5.0; // Declare Solidity language and version

contract TodoList { // Declare the smart contract
    // Code goes here
    uint public todoCount = 0; // Use uint instead of int because todoCount should never be a negative number, declared public

    constructor() public {
        addTask("Initial Task");
    }

    struct Task { // Define the struct data types for our tasks
        uint id; // Task ID - uint because it shouldn't be negative
        string details; // The task details
        bool completed; // Is the task completed? True/False
    }

    mapping(uint => Task) public tasks;  // Use mapping to create the array

    function addTask(string memory _details) public { // Function to create a new task
        todoCount ++; // Increment the counter
        tasks[todoCount] = Task(todoCount, _details, false); // Create task with new ID, the content and set completed to false
    }

}
