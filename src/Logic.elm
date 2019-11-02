module Logic exposing (..)

import DataModel exposing (..)


type alias Index =
    Int


type Msg
    = PaintColor DataModel.Color
    | EraseColor Index
    | Submit


updateWithNoCommand : Msg -> GameBoard -> GameBoard
updateWithNoCommand msg gameBoard =
    case msg of
        PaintColor color ->
            { gameBoard | currentAttempt = paintFirstEmptyToColorSpot color gameBoard.currentAttempt }

        EraseColor index ->
            { gameBoard | currentAttempt = eraseColorAtIndex index gameBoard.currentAttempt }

        Submit ->
            gameBoard


eraseColorAtIndex : Index -> Attempt -> Attempt
eraseColorAtIndex index attempt =
    List.indexedMap (eraseWhenIndexEquals index) attempt


eraseWhenIndexEquals : Index -> Index -> ColorSpot -> ColorSpot
eraseWhenIndexEquals i1 i2 currentColorSpot =
    if i1 == i2 then
        Nothing

    else
        currentColorSpot


paintFirstEmptyToColorSpot : Color -> Attempt -> Attempt
paintFirstEmptyToColorSpot color attempt =
    case attempt of
        (Just x) :: xs ->
            Just x :: paintFirstEmptyToColorSpot color xs

        Nothing :: xs ->
            Just color :: xs

        [] ->
            []
