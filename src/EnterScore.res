@react.component
let make = (~onOk: int => unit) => {
  let (scoreText, setScoreText) = React.useState(() => "")

  let inputContent = () => {
    <input
      type_="text"
      className="flex-grow  rounded p-3 text-blue-900 border-2 border-blue-900"
      value={scoreText}
      onChange={e => {
        let text = ReactEvent.Form.target(e)["value"]
        setScoreText(_ => text)
      }}
    />
  }

  let sendInput = () => {
    let mv = Belt.Int.fromString(scoreText)
    switch mv {
    | Some(v) => {
        setScoreText(_ => "")
        onOk(v)
    }
    | None => ()
    }
  }

  let submit = event => {
    event->ReactEvent.Mouse.preventDefault
    event->ReactEvent.Mouse.stopPropagation
    sendInput()
  }

  let handleFormSubmit = (event: ReactEvent.Form.t) => {
    event->ReactEvent.Form.preventDefault
    event->ReactEvent.Form.stopPropagation
    sendInput()
  }

  <>
    <div className="text-lg text-blue-900 p-4 pl-0"> {React.string("Enter Score")} </div>
    <form onSubmit={handleFormSubmit} className="flex gap-3">
      {inputContent()}
      <button
        className="flex-none bg-blue-400 text-white p-4 rounded" type_="button" onClick={submit}>
        {React.string("Ok")}
      </button>
    </form>
  </>
}
