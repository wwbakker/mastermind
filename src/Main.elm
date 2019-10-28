module Main exposing (main)

import Browser
import DataModel exposing (GameBoard, initialGameBoard)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Visuals exposing (renderGameBoard)


main : Program () GameBoard Msg
main =
    Browser.element { init = \() -> init, view = view >> toUnstyled, update = update, subscriptions = \_ -> Sub.none }


init : ( GameBoard, Cmd message )
init =
    ( initialGameBoard, Cmd.none )


update : Msg -> GameBoard -> ( GameBoard, Cmd Msg )
update msg gameBoard =
    ( gameBoard, Cmd.none )


type Msg
    = A String


view : GameBoard -> Html Msg
view gameBoard =
    renderGameBoard gameBoard
