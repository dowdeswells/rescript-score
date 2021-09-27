@react.component
let make = (~onOk: array<string> => unit) => {
  let (teamNames, setTeamNames) = React.useState(() => [""])

  let content = (i, _) => {
      <input
        key={Belt.Int.toString(i)}
        className="rounded p-3 text-blue-900 border-2 border-blue-900"
        type_="text"
        value={teamNames[i]}
        onChange={e => {
          let text = ReactEvent.Form.target(e)["value"]

          setTeamNames(prev => {
            Belt.Array.mapWithIndex(prev, (ri, n) => {ri == i ? text : n})
          })
        }}
      />

  }

  let addTeamName = event => {
    event->ReactEvent.Mouse.preventDefault
    event->ReactEvent.Mouse.stopPropagation
    setTeamNames(prev => Belt.Array.concat(prev, [""]))
  }

  let submit = event => {
    event->ReactEvent.Mouse.preventDefault
    event->ReactEvent.Mouse.stopPropagation
    onOk(teamNames)
  }

  let handleFormSubmit = (event:ReactEvent.Form.t) => {
    event->ReactEvent.Form.preventDefault
    event->ReactEvent.Form.stopPropagation
    onOk(teamNames)
  }

  <div className="bg-gray-100 rounded p-2">
    
    <form onSubmit={handleFormSubmit}>
      <div className="flex">
        <h2 className="flex-grow text-lg text-blue-900 p-4"> {React.string("Configure teams")} </h2>
        <button className="flex-none bg-blue-400 text-white p-2 rounded" type_="button" onClick={addTeamName}> {React.string("Add Team")} </button>
      </div>

      
      <div className="grid grid-cols-1 gap-3 p-4"> {teamNames->Belt.Array.mapWithIndex(content)->React.array} </div>
      <div className="grid justify-items-end">
        <button className="bg-blue-400 text-white p-4 rounded" type_="button" onClick={submit}> {React.string("Ok")} </button>
      </div>
      
    </form>
  </div>
}
