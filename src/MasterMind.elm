module MasterMind exposing (main)

import Browser
import DataModel exposing (GameBoard, initialGameBoard)
import Html.Styled exposing (Html, toUnstyled)
import Logic exposing (Msg, generateNewSolution)
import Visuals


main : Program () GameBoard Msg
main =
    Browser.element { init = \() -> init, view = view >> toUnstyled, update = update, subscriptions = \_ -> Sub.none }


init : ( GameBoard, Cmd Msg )
init =
    ( initialGameBoard, generateNewSolution )


update : Msg -> GameBoard -> ( GameBoard, Cmd Msg )
update msg gameBoard =
    ( Logic.updateWithNoCommand msg gameBoard, Cmd.none )


view : GameBoard -> Html Msg
view gameBoard =
    Visuals.renderGameBoard gameBoard
