
let recordAScore = () => {
    <div>{React.string("NA")}</div>
}

let teamScoresContent = (i, score) => {
    <span key={Belt.Int.toString(i)}>{
        switch score {
        | Game.NotRecorded => recordAScore()
        | Recorded (scoreValue) => 
            <span>{
                scoreValue
                -> Belt.Int.toString
                -> React.string}
            </span>
        }
    }</span>
}

let teamContent = (i, s) => {

    let (Game.TeamName(name), scores) = s
    <div key={Belt.Int.toString(i)}>
        <div>{React.string(name)}</div>
        <div>
            {scores
            -> Belt.List.mapWithIndex(teamScoresContent)
            -> Belt.List.toArray
            -> React.array}
        </div>
    </div>
}

@react.component
let make = (~teamScores:array<Game.teamScore>, ~currentTeam:int) => {
    <>
        <div>{React.string("ScoresView " ++ Belt.Int.toString(currentTeam))}</div>
        <div>
            {teamScores
            -> Belt.Array.mapWithIndex(teamContent)
            -> React.array}
        </div>
    </>
}