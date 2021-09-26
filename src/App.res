

type gameState = 
  NoGame
  | Playing (array<Game.teamScore>)

type gameAction = 
  Configured (array<string>)
  | NextRound

let playGame = (teams:array<string>) => Playing (Belt.Array.map(teams, 
    (t) => {
      (Game.TeamName(t), list{Game.NotRecorded})
    })
  )

let addRound = (gs) => {
  switch gs {
    | NoGame => playGame(["Unknown"])
    | Playing (teamScores) => Playing (Belt.Array.map(teamScores, score => {
        let (Game.TeamName(name), scores) = score
        (
          Game.TeamName(name),
          list{Game.NotRecorded, ...scores}
        )
      }))
  }
}

let reducer = (gameState, gameAction) => {
  switch gameAction {
  | Configured(teams) => playGame(teams)
  | NextRound => addRound(gameState)
  }
}

@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, NoGame)
  switch state {
    | NoGame => 
      <ConfigureTeams
        onOk={ (teamNames) => dispatch(Configured(teamNames))}
      /> 
    | Playing(teamScores) => 
      <div>
        <ScoresView teamScores={teamScores}/>
      </div>
      
  }
}
