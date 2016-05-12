import Html exposing (div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Html.App
import Mouse as Mouse
import Platform.Cmd as Cmd exposing (Cmd)


main = Html.App.program 
    { init = (init, Cmd.none)
    , view = view
    , update = update 
    , subscriptions = subscriptions
    }


-- MODEL

type SquareColor = White | Red | Blue | Green | Cyan
type alias Model = 
    { x: Int
    , y: Int
    , color: SquareColor
    }

init : Model
init = { x = 0, y = 0, color = White }

type Msg = MouseMove Mouse.Position | MouseClick Mouse.Position


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    let 
        mouseMoves  = Mouse.moves MouseMove 
        mouseClicks = Mouse.clicks MouseClick 
    in
    Sub.batch [mouseMoves, mouseClicks]


-- UPDATE

update action model = 
    case action of
        MouseClick _ -> 
            let nextColor (currentColor) =
                case currentColor of
                    White -> Red
                    Red   -> Blue
                    Blue  -> Green
                    Green -> Cyan
                    Cyan  -> White
            in
                ({ model | color = (nextColor model.color) }, Cmd.none)

        MouseMove pos -> 
            ({ model | x = pos.x, y = pos.y }, Cmd.none)


renderColor : SquareColor -> String
renderColor c =
    case c of
        White -> "white"
        Red   -> "red"
        Blue  -> "blue"
        Green -> "green"
        Cyan  -> "cyan"


-- VIEW

view model =
    let squareStyle = style [ ("background", (renderColor model.color))
                            , ("height", "50px")
                            , ("width", "50px")
                            , ("position", "absolute")
                            , ("top", (toString (model.y - 25) ++ "px") )
                            , ("left", (toString (model.x - 25) ++ "px"))
                            ]
    in
        div [ (style [ ("min-height", "1024px"), ("width", "100%"), ("background", "#000") ]) ] [
            div [ squareStyle ] [ (text " ") ]
        ]


