pragma solidity ^0.5.0; // Declare Solidity language and version

contract TodoList { // Declare the smart contract
    // Code goes here
    uint public todoCount = 0; // Use uint instead of int because todoCount should never be a negative number, declared public

    event TaskCreated( // declare event to broadcast (emit) that task was created
        uint id, // Task ID
        string details, // Task details
        bool completed // Is the task complete true/false
    );

    event TaskCompleted( // Declare event to broadcast (emit) task completed
        uint id, // Task ID
        bool completed // Is the task comleted true/false
    );

    constructor() public { // Constructor function to run on contract deployment
        addTask("Initial Task"); // Put an item in the list for first run
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
        emit TaskCreated(todoCount, _details, false); // Broadcast event that task was created
    }

    function toggleCompleted(uint _id) public { // Function to change bool completed from True to False and False to True
        Task memory _task = tasks[_id]; // Find the task ID to toggle out of the mapping
        _task.completed =! _task.completed; // Toggle it. If True, make false. If false, make true
        tasks[_id] = _task; // write the results to the mapping
        emit TaskCompleted(_id, _task.completed); // Broadcast event that task was toggled
    }

}
