type teamName = TeamName(string)

type gameScore =
  | NotRecorded
  | Recorded(int)

type teamScore = (teamName, list<gameScore>, int)


let getTotal = (ts:teamScore) => {
  let (_, _, currentTotal) = ts
  currentTotal
}
