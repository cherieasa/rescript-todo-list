@react.component
let make = (~setTodos, ~todos, ~filteredTodos) => {

    <div className="todo-container">
      <ul className="todo-list">
        (
          {React.array(Array.map(
            (todo:UtilTodo.Todo.todo) => 
            <TodoItem 
              setTodos 
              todos 
              todo 
              key={Belt.Int.toString(todo.id)} 
              />, filteredTodos
          )
        )})
      </ul>
    </div>
};