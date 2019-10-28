module DataModel exposing (..)


type alias GameBoard =
    { palette : Palette
    , currentAttempt : Attempt
    , log : Log
    }


type alias Palette =
    List Color


type alias Log =
    List PastAttempt


initialGameBoard : GameBoard
initialGameBoard =
    { palette = [ Red, Blue, Green, Yellow, Grey ]
    , currentAttempt = []
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
