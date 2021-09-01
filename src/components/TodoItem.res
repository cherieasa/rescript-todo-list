@react.component
let make = (~setTodos, ~todos, ~todo:UtilTodo.Todo.todo, ~id, ~text) => {

    let deleteHandler = (evt) => {
        ReactEvent.Mouse.preventDefault(evt);
        setTodos(_ => UtilTodo.Todo.handleCase(Delete(id), todos));
    };

    let completeHandler = (evt) => {
        ReactEvent.Mouse.preventDefault(evt);
        setTodos(_ => UtilTodo.Todo.handleCase(Complete(id), todos));
    };

    <div className="todo">
        <li className={`todo-item ${todo.completed ? "completed" : ""}`}>
            (React.string(text))
        </li>
        <button onClick= {completeHandler} className="complete-btn">
            <i className="fas fa-check"></i>
        </button>
        <button onClick={deleteHandler} className="trash-btn">
            <i className="fas fa-trash"></i>
        </button>
    </div>
};