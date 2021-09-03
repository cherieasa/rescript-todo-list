module Storage = {

    type todo = ReasonReactStarter.UtilTodo.Todo.todo

    // Local Save
    let saveLocalTodos = (todos: Js.Array.t<ReasonReactStarter.UtilTodo.Todo.todo>) => {

        let arrayOftodoArray = Array.map((todo:todo) => {
            [todo.id->Belt.Int.toString, todo.text, todo.completed->string_of_bool]
        }, todos)

        let str = Js.Json.stringifyAny(todos);
        switch(str){
            | Some(s) => Dom.Storage.setItem("todos", s, Dom.Storage.localStorage);
            Js.log3("setItem", arrayOftodoArray, s)
            | None => ()
        }
        
        // Js.log(arrayOftodoArray) /// [["1","dothis","true"], ...]

        // Js.Array.joinWith("-", ["1","dothis","true"]) -> Js.log   /// 1-dothis-true

    };

    // declare the shape of the json you're binding to
    type data = array<todo>;

    // bind to JS' JSON.parse
    @scope("JSON") @val
    external parseIntoMyData: string => data = "parse"

    let getLocalTodos = () => {
        let todosStr = Dom.Storage.getItem("todos", Dom.Storage.localStorage)
        
        let todos = todosStr->Belt.Option.map(parseIntoMyData)
        Js.log3("get local todos", todosStr, todos)
        todos
        // if (Dom.Storage.getItem("todos", Dom.Storage.localStorage) === None){
        //     Dom.Storage.setItem("todos", "[]", Dom.Storage.localStorage);
        //     Js.log(Dom.Storage.localStorage)
        // } else {
        //     let todoLocal = Dom.Storage.getItem("todos", Dom.Storage.localStorage);
        //     switch(todoLocal){
        //         | Some(s) => setTodos(_ => parseIntoMyData(s))
        //         | None => ()
        //     }
        // }
    };

}