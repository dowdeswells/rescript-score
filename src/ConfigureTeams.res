@react.component
let make = (~onOk: array<string> => unit) => {
  let (teamNames, setTeamNames) = React.useState(() => [""])

  let content = (i, _) => {
    <div key={Belt.Int.toString(i)}>
      <input
        type_="text"
        value={teamNames[i]}
        onChange={e => {
          let text = ReactEvent.Form.target(e)["value"]

          setTeamNames(prev => {
            Belt.Array.mapWithIndex(prev, (ri, n) => {ri == i ? text : n})
          })
        }}
      />
    </div>
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

  <>
    <div> {React.string("Configure teams first")} </div>
    <form>
      <button type_="button" onClick={addTeamName}> {React.string("Add Team")} </button>
      <button type_="button" onClick={submit}> {React.string("Ok")} </button>
      <div> {teamNames->Belt.Array.mapWithIndex(content)->React.array} </div>
    </form>
  </>
}
