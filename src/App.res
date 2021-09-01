@react.component
let make = () => {

  // For getting input Text and resetting it back to ""
  let (inputText, setInputText) = React.useState(_ => "");
  // For changing our list of todos and setting field of each todo
  let (todos, setTodos) = React.useState(_ => []);
  // For changing category -> all, completed, uncompleted
  let (status, setStatus) = React.useState(_ => "all")
  // For filtering our todo list for each category
  let (filteredTodos, setFilteredTodos) = React.useState(_ => []);

  let filterHandler = () => {
    switch status {
      | "completed" => setFilteredTodos(_ => UtilTodo.Todo.filterComplete(todos))
      | "uncompleted" => setFilteredTodos(_ => UtilTodo.Todo.filterUncomplete(todos))
      | "all" => setFilteredTodos(_ => todos)
    }
  };
  
  <div className="App">
    <header>
      <h1>(React.string("Rescript React Todo List"))</h1>
    </header>
    <Form setInputText inputText todos setTodos setStatus />
    <TodoList setTodos todos />
  </div>
};