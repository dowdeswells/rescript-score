
type teamName = TeamName (string)

type gameScore =
  NotRecorded
  | Recorded (int)

type teamScore = (teamName,  list<gameScore>)
