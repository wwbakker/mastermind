module Visuals exposing (..)

import Css exposing (Style, backgroundColor, display, height, inlineBlock, none, px, rgb, solid, width)
import DataModel exposing (..)
import Html.Styled exposing (Html, button, div, text)
import Html.Styled.Attributes exposing (css, disabled)
import Html.Styled.Events exposing (onClick)
import Logic



--import Logic exposing (..)


placeholder : Html msg
placeholder =
    div [] []



--renderGameBoardUnstyled : GameBoard -> VirtualDom.Node msg
--renderGameBoardUnstyled gameBoard =
--    toUnstyled (renderGameBoard gameBoard)


renderGameBoard : GameBoard -> Html Logic.Msg
renderGameBoard gameBoard =
    div []
        [ renderPalette gameBoard.palette
        , renderCurrentAttempt gameBoard.currentAttempt
        , renderButton gameBoard
        , renderLog gameBoard.log
        ]


renderButton : GameBoard -> Html Logic.Msg
renderButton gameBoard =
    button
        [ onClick Logic.Submit
        , disabled (not (Logic.isAttemptValid gameBoard.currentAttempt))
        ]
        [ text "submit" ]


renderPalette : Palette -> Html Logic.Msg
renderPalette palette =
    div [] (text "Palette: " :: List.map renderPaletteBox palette)


renderCurrentAttempt : Attempt -> Html Logic.Msg
renderCurrentAttempt attempt =
    div [] (List.indexedMap renderCurrentAttemptBox attempt)


renderAttempt : Attempt -> Html msg
renderAttempt attempt =
    div [] (List.map renderAttemptBox attempt)


renderPastAttempt : PastAttempt -> Html msg
renderPastAttempt pastAttempt =
    div [] [ renderAttempt pastAttempt.attempt, renderGrade pastAttempt.grade ]


renderGrade : Grade -> Html msg
renderGrade grade =
    div [] (List.map renderGradeResult grade)


renderGradeResult : GradeResult -> Html msg
renderGradeResult gradeResult =
    case gradeResult of
        ColorAndPositionMatch ->
            text "✔"

        ColorMatch ->
            text "♦"

        NoMatch ->
            text "✗"


renderLog : Log -> Html msg
renderLog log =
    div [] (List.map renderPastAttempt log)


type Border
    = BlackBorder
    | NoBorder


toBorderStyle : Border -> Style
toBorderStyle borderType =
    case borderType of
        BlackBorder ->
            Css.border3 (px 5) solid (rgb 0 0 0)

        NoBorder ->
            Css.borderStyle none


renderPaletteBox : DataModel.Color -> Html Logic.Msg
renderPaletteBox color =
    renderBox
        [ toBorderStyle NoBorder
        , backgroundColor (colorToRgb color)
        ]
        [ onClick (Logic.PaintColor color) ]


renderAttemptBox : DataModel.ColorSpot -> Html msg
renderAttemptBox color =
    renderBox
        [ toBorderStyle BlackBorder
        , backgroundColor (colorSpotToRgb color)
        ]
        []


renderCurrentAttemptBox : Logic.Index -> DataModel.ColorSpot -> Html Logic.Msg
renderCurrentAttemptBox index color =
    renderBox
        [ toBorderStyle BlackBorder
        , backgroundColor (colorSpotToRgb color)
        ]
        [ onClick (Logic.EraseColor index) ]


renderBox : List Style -> List (Html.Styled.Attribute msg) -> Html msg
renderBox styles otherAttributes =
    div
        (List.append
            [ css
                (List.append styles
                    [ display inlineBlock
                    , width (px 25)
                    , height (px 25)
                    ]
                )
            ]
            otherAttributes
        )
        []


colorSpotToRgb : DataModel.ColorSpot -> Css.Color
colorSpotToRgb colorSpot =
    case colorSpot of
        Just color ->
            colorToRgb color

        Nothing ->
            rgb 255 255 255


colorToRgb : DataModel.Color -> Css.Color
colorToRgb color =
    case color of
        Red ->
            rgb 255 0 0

        Blue ->
            rgb 0 0 255

        Green ->
            rgb 0 255 0

        Yellow ->
            rgb 255 255 0

        Grey ->
            rgb 125 125 125


conditionalOn : Bool -> List Style -> List Style
conditionalOn isSelected conditionalStyle =
    if isSelected then
        conditionalStyle

    else
        []
