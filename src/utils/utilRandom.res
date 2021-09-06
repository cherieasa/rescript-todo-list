module Response = {
  type t<'data>
  @send external json: t<'data> => Promise.t<'data> = "json"
}

module RandomAct = {
  type t = {"activity": string, "type": string, "participants": int, "price": int, "link": string, "key": string, "accessibility":float}

  @val @scope("globalThis")
  external fetch: (string, 'params) => Promise.t<Response.t<t>> =
    "fetch"

  let getRandomAct = () => {
    open Promise

    let url = "http://www.boredapi.com/api/activity/"
    let params = {
        "method": "GET",
        "headers": {
            "Content-Type": "application/json",
        },
    }
    fetch(url, params)
    ->then(res => Response.json(res))
    ->then(data => {
        Js.log(data)
        Ok(data)->resolve
        })
    ->catch(e => {
        let msg = switch e {
        | JsError(err) =>
            switch Js.Exn.message(err) {
            | Some(msg) => msg
            | None => ""
            }
        | _ => "Unexpected error occurred"
        }
        Error(msg)->resolve
        })
    }
}
