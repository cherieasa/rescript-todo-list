@react.component
let make = (~setInputText, ~inputText, ~todos, ~setTodos, ~setStatus) => {
    
    let inputTextHandler = (evt) => {
        let value = ReactEvent.Form.target(evt)["value"]
        setInputText(_ => value);
    };

    let submitTodoHandler = (evt) => {
        ReactEvent.Mouse.preventDefault(evt); // prevents default behavior of refreshing the page
        setTodos(_ => UtilTodo.Todo.handleCase(New(inputText), todos));
        setInputText(_ => ""); 
    };

    let statusHandler = (evt) => {
        let value = ReactEvent.Form.target(evt)["value"]
        setStatus(_ => value);
    };

    <form>
        <input value={inputText} onChange={inputTextHandler} type_="text" className="todo-input" />
        <button onClick={submitTodoHandler} className="todo-button" type_="submit">
            <i className="fas fa-plus-square"></i>
        </button>
        <div className="select">
            <select onChange={statusHandler} name="todos" className="filter-todo">
                <option value="all">(React.string("All"))</option>
                <option value="completed">(React.string("Completed"))</option>
                <option value="uncompleted">(React.string("Uncompleted"))</option>
            </select>
        </div>
    </form>
}