@react.component
let make = (~inputText, ~setInputText, ~todos, ~setTodos, ~setStatus) => {
    
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

    let clearHandler = (evt) => {
        ReactEvent.Mouse.preventDefault(evt);
        setTodos(_ => [])
    }


    let fetchHandler = (evt) => {
        ReactEvent.Mouse.preventDefault(evt);

        exception FailedRequest(string)
        let _ = {
        open Promise
        UtilRandom.RandomAct.getRandomAct()
        ->then(result => {
            switch result {
            | Ok(activity) => Js.log(activity)
            setTodos(_ => UtilTodo.Todo.handleCase(New(activity["activity"]), todos));
            | Error(msg) => Js.log("Could not query products: " ++ msg)
            }->resolve
        })
        ->catch(e => {
            switch e {
            | FailedRequest(msg) => Js.log("Operation failed! " ++ msg)
            | _ => Js.log("Unknown error")
            }
            resolve()
        })
        }
        // setTodos(_ => UtilTodo.Todo.handleCase(New(randomTodo), todos));
    }

    <form>
        <button onClick={clearHandler} className="clear" type_="submit">
            (React.string("Clear"))
        </button>
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
        <button onClick={fetchHandler} className="random" type_="submit">
            <i className="fas fa-random"></i>
        </button>
    </form>
}