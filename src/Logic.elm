module Logic exposing (..)

import DataModel exposing (..)
import List.Extra
import Random
import Utilities exposing (isJust)


type alias Index =
    Int


type Msg
    = NewSolution Solution
    | PaintColor DataModel.Color
    | EraseColor Index
    | Submit


generateNewSolution : Cmd Msg
generateNewSolution =
    Random.generate NewSolution randomSolution


updateWithNoCommand : Msg -> GameBoard -> GameBoard
updateWithNoCommand msg gameBoard =
    case msg of
        NewSolution solution ->
            { gameBoard | solution = solution }

        PaintColor color ->
            { gameBoard | currentAttempt = paintFirstEmptyToColorSpot color gameBoard.currentAttempt }

        EraseColor index ->
            { gameBoard | currentAttempt = eraseColorAtIndex index gameBoard.currentAttempt }

        Submit ->
            { gameBoard | currentAttempt = emptyAttempt, log = gradeAttempt gameBoard.currentAttempt gameBoard.solution :: gameBoard.log }


gradeAttempt : Attempt -> Solution -> PastAttempt
gradeAttempt currentAttempt solution =
    { attempt = currentAttempt
    , grade = orderGrade (List.indexedMap (gradeSpot solution) currentAttempt)
    }


orderGrade : Grade -> Grade
orderGrade grade =
    List.append (List.filter (\g -> g == ColorAndPositionMatch) grade) (List.filter (\g -> g == ColorMatch) grade)


gradeSpot : Solution -> Index -> ColorSpot -> GradeResult
gradeSpot solution index colorSpot =
    case List.Extra.getAt index solution of
        Just color ->
            if Just color == colorSpot then
                ColorAndPositionMatch

            else if List.any (\c -> Just c == colorSpot) solution then
                ColorMatch

            else
                NoMatch

        Nothing ->
            NoMatch


isAttemptValid : Attempt -> Bool
isAttemptValid attempt =
    List.all isJust attempt


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
