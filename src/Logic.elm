module Logic exposing (..)

import DataModel exposing (..)
import Random
import Utilities exposing (count, isJust)


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
    , grade = calculateGrade currentAttempt solution
    }


calculateGrade : Attempt -> Solution -> Grade
calculateGrade attempt solution =
    gradeFromTuple
        (sumMatches
            (List.map (calculatePositionColorAndColorMatches attempt solution) DataModel.allColors)
        )


sumMatches : List ( Int, Int ) -> ( Int, Int )
sumMatches matches =
    List.foldl sumPair ( 0, 0 ) matches


sumPair : ( Int, Int ) -> ( Int, Int ) -> ( Int, Int )
sumPair ( a1, a2 ) ( b1, b2 ) =
    ( a1 + b1, a2 + b2 )


calculatePositionColorAndColorMatches : Attempt -> Solution -> Color -> ( Int, Int )
calculatePositionColorAndColorMatches attempt solution color =
    let
        numberOfColorAndPositionMatches =
            countNumberOfColorAndPositionMatches attempt solution color

        numberOfcolorMatches =
            countNumberOfColorMatches attempt solution color
    in
    ( numberOfColorAndPositionMatches, numberOfcolorMatches - numberOfColorAndPositionMatches )


countNumberOfColorAndPositionMatches : Attempt -> Solution -> Color -> Int
countNumberOfColorAndPositionMatches attempt solution color =
    count (colorAndPositionMatches color) (List.map2 Tuple.pair attempt solution)


colorAndPositionMatches : Color -> ( ColorSpot, Color ) -> Bool
colorAndPositionMatches color match =
    color == Tuple.second match && Just color == Tuple.first match


countNumberOfColorMatches : Attempt -> Solution -> Color -> Int
countNumberOfColorMatches attempt solution color =
    min (countNumberOfColorInAttempt color attempt) (countNumberOfColorInSolution color solution)


countNumberOfColorInSolution : Color -> Solution -> Int
countNumberOfColorInSolution color solution =
    count (\c -> c == color) solution


countNumberOfColorInAttempt : Color -> Attempt -> Int
countNumberOfColorInAttempt color attempt =
    count (\a -> a == Just color) attempt


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
