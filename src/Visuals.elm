module Visuals exposing (..)

import Css exposing (..)
import DataModel exposing (..)
import Html.Styled exposing (Html, div, text)
import Html.Styled.Attributes exposing (css)
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
        , renderLog gameBoard.log
        ]


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
    placeholder


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
