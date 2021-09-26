

@react.component
let make = (~onOk:(int) => unit) => {

    let (scoreText, setScoreText) = React.useState(() => "")

    let inputContent = () => {
        <div>
            <input
                type_="text"
                value={scoreText}
                onChange={(e) =>{
                    let text = ReactEvent.Form.target(e)["value"]                 
                    setScoreText(_ => text)
                    }
                }
            />
        </div>
    }

    let submit=(event) => {
        event->ReactEvent.Mouse.preventDefault
        event->ReactEvent.Mouse.stopPropagation

        let mv = Belt.Int.fromString(scoreText)
        switch mv {
            |Some(v) => onOk(v)
            |None => ()
        }
    }

    <>
      <div>{React.string("Enter Score")}</div>
      <form>

        <button type_="button" onClick={submit}>{React.string("Ok")}</button>
        <div>
            {inputContent()}
        </div>
      </form>
    </>
}