
%%raw("import './app.css'")

type gameState =
  | NoGame
  | Playing(array<Game.teamScore>, int)

type gameAction =
  | Configured(array<string>)
  | RecordScore(int)

let playGame = (teams: array<string>) => Playing(
  Belt.Array.map(teams, t => {
    (Game.TeamName(t), list{}, 0)
  }),
  0,
)

let addRound = (gs, scoreValue) => {
  switch gs {
  | NoGame => playGame(["Unknown"])
  | Playing(teamScores, currentTeam) => {
      let nextTeam = mod(currentTeam + 1, Belt.Array.length(teamScores))
      Playing(
        Belt.Array.mapWithIndex(teamScores, (teamIndex, score) => {
          let (Game.TeamName(name), scores, currentTotal) = score
          teamIndex == currentTeam
            ? (Game.TeamName(name), list{Game.Recorded(scoreValue), ...scores}, currentTotal + scoreValue)
            : (Game.TeamName(name), scores, currentTotal)
        }),
        nextTeam,
      )
    }
  }
}

let reducer = (gameState, gameAction) => {
  switch gameAction {
  | Configured(teams) => playGame(teams)
  | RecordScore(score) => addRound(gameState, score)
  }
}

@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, NoGame)

  <div className="bg-gray-300 p-8"> 
  {
    switch state {
    | NoGame => <ConfigureTeams onOk={teamNames => dispatch(Configured(teamNames))} />
    | Playing(teamScores, currentTeam) =>
      <div>
        <ScoresView teamScores={teamScores} currentTeam={currentTeam} />
        <EnterScore onOk={newScore => dispatch(RecordScore(newScore))} />
      </div>
    }
  }
  </div>

}
