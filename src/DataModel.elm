module DataModel exposing (..)

import Random


type alias GameBoard =
    { solution : Solution
    , palette : Palette
    , currentAttempt : Attempt
    , log : Log
    }


type alias Palette =
    List PinColor


type alias Solution =
    List PinColor


type alias Log =
    List PastAttempt


emptyAttempt : Attempt
emptyAttempt =
    [ Nothing, Nothing, Nothing, Nothing, Nothing ]


allColors : List PinColor
allColors =
    [ Red, Blue, Green, Yellow, Grey ]


randomColor : Random.Generator PinColor
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


type PinColor
    = Red
    | Blue
    | Green
    | Yellow
    | Grey


type alias ColorSpot =
    Maybe PinColor


type alias Grade =
    { colorAndPositionMatches : Int
    , colorOnlyMatches : Int
    }


gradeFromTuple : ( Int, Int ) -> Grade
gradeFromTuple ( cp, co ) =
    Grade cp co


type alias PastAttempt =
    { attempt : Attempt
    , grade : Grade
    }
