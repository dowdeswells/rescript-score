let recordAScore = () => {
  <div> {React.string("NA")} </div>
}

let teamScoresContent = (i, score) => {
  <button className="text-blue-900 bg-blue-100 p-2 border-2 border-blue-900" key={Belt.Int.toString(i)}>
    {switch score {
    | Game.NotRecorded => recordAScore()
    | Recorded(scoreValue) => <span> {scoreValue->Belt.Int.toString->React.string} </span>
    }}
  </button>
}

let teamContent = (i, s) => {
  let (Game.TeamName(name), scores, currentTotal) = s
  <div key={Belt.Int.toString(i)}>
    <div> {React.string(name)} </div>
    <div className="flex flex-wrap gap-1"> 
        <div className="text-white bg-blue-600 p-2 border-4 border-blue-900">{currentTotal->Belt.Int.toString->React.string}</div>
        {scores->Belt.List.mapWithIndex(teamScoresContent)->Belt.List.toArray->React.array} 
    </div>
  </div>
}

let teamName = (teamScores, teamIndex) => {
    let (Game.TeamName(name), _, _) = teamScores[teamIndex]
    name
}

@react.component
let make = (~teamScores: array<Game.teamScore>, ~currentTeam: int) => {
  <>
    <div> {React.string("Scores " ++ teamName(teamScores, currentTeam))} </div>
    <div > {teamScores->Belt.Array.mapWithIndex(teamContent)->React.array} </div>
  </>
}
