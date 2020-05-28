const TodoList = artifacts.require('./TodoList.sol') // Require the actual smart contract we are testing

contract('TodoList', (accounts) => { // Callback function to expose the accounts in an array
  before(async () => { // Before hook to deployed copy of the smart contract
    this.todoList = await TodoList.deployed()
  })

  it('deploys successfully', async () => { //Check if deployed seccessfuly
    const address = await this.todoList.address // Get the address of the contract
    assert.notEqual(address, 0x0) // Check it's not 0x0
    assert.notEqual(address, '') // Check not empty string
    assert.notEqual(address, null) // Check not null
    assert.notEqual(address, undefined) // Check not undefined
  })

  it('lists tasks', async () => { // List the tasks
    const todoCount = await this.todoList.todoCount() // Get the count of todos
    const task = await this.todoList.tasks(todoCount) // fetch the tasks
    assert.equal(task.id.toNumber(), todoCount.toNumber()) // check id equals count
    assert.equal(task.details, 'Initial Task') // check the task details are correct
    assert.equal(task.completed, false) // check initial task is not completed
    assert.equal(todoCount.toNumber(), 1) //check todo count is actually 1
  })

  it('adds tasks', async () => { // Check creating task
    const result = await this.todoList.addTask('A New Task') // New todo called A New Task
    const todoCount = await this.todoList.todoCount() // Check todo count
    assert.equal(todoCount, 2) // Check that it is equal to 2
    const event = result.logs[0].args // Check that event was triggered
    assert.equal(event.id.toNumber(), 2) // Event ID equals 2
    assert.equal(event.details, 'A New Task') // Event details is A New Task
    assert.equal(event.completed, false) // Event completed should be false
  })

  it('toggles task completion', async () => { // Check toggle complete book
    const result = await this.todoList.toggleCompleted(1) // Mark task 1 as complete
    const task = await this.todoList.tasks(1) // Get task 1 data
    assert.equal(task.completed, true) // Check complete equals true
    const event = result.logs[0].args // Check Event was truggered
    assert.equal(event.id.toNumber(), 1) // Check event ID equals 1
    assert.equal(event.completed, true) // Check event completed equals true
  })

})
