module DataModel exposing (..)

import Random


type alias GameBoard =
    { solution : Solution
    , palette : Palette
    , currentAttempt : Attempt
    , log : Log
    }


type alias Palette =
    List Color


type alias Solution =
    List Color


type alias Log =
    List PastAttempt


emptyAttempt : Attempt
emptyAttempt =
    [ Nothing, Nothing, Nothing, Nothing, Nothing ]


allColors : List Color
allColors =
    [ Red, Blue, Green, Yellow, Grey ]


randomColor : Random.Generator Color
randomColor =
    Random.uniform Red [ Blue, Green, Yellow, Grey ]


randomSolution : Random.Generator Solution
randomSolution =
    Random.list 5 randomColor


initialGameBoard : GameBoard
initialGameBoard =
    { solution = []
    , palette = allColors
    , currentAttempt = emptyAttempt
    , log = []
    }


type alias Attempt =
    List ColorSpot


type Color
    = Red
    | Blue
    | Green
    | Yellow
    | Grey


type alias ColorSpot =
    Maybe Color


type alias Grade =
    List GradeResult


type GradeResult
    = ColorAndPositionMatch
    | ColorMatch
    | NoMatch


type alias PastAttempt =
    { attempt : Attempt
    , grade : Grade
    }
