module Todo = {

    type todo = {
        id: int,
        text: string,
        completed: bool
    };

    type state = {
        todos: array<todo>
    };

    type action =
    | New(string) // Add a todo with a text
    | Complete(int) // Check a todo based on it's ID
    | Delete(int); // Delete a todo based on it's ID

    let todoId = ref(0); // to make it mutable

    // Function to create a new todo
    let newTodo = (text) => {
        todoId := todoId.contents + 1;
        [{id: todoId.contents, text: text, completed: false}]
    };

    // Function to complete a todo
    let completeTodo = (id, todos) => {
        Array.map( item => {
            if (item.id === id){ 
                {...item, completed: !item.completed} // take all the properties of item but change completed
            } else {
                item;
            }
        }, todos)
    };

    // Function to delete a todo
    let deleteTodo = (id, todos) => { 
        // filter out same todo id that we press delete on, if it matches it removes it 
        Js.Array.filter( item => {item.id !== id}, todos) 
    }

    // Function to handle action
    let handleCase = (action, todos)=> {
        switch action {
            | New(text) => Belt.Array.concat(todos, newTodo(text))
            | Complete(id) => completeTodo(id, todos)
            | Delete(id) => deleteTodo(id, todos)
        }
    };  

    // Function to filter out completed todos
    let filterComplete = (todos) => {
        Js.Array.filter( todo => {todo.completed === true}, todos) 
    };

    // Function to filter out uncompleted todos
    let filterUncomplete = (todos) => {
        Js.Array.filter( todo => {todo.completed === false}, todos) 
    };
}