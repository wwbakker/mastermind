module Visuals exposing (..)

import Css exposing (..)
import DataModel exposing (..)
import Html.Styled exposing (Html, div, text)
import Html.Styled.Attributes exposing (css)


placeholder : Html msg
placeholder =
    div [] []


renderGameBoard : GameBoard -> Html msg
renderGameBoard gameBoard =
    div []
        [ renderPalette gameBoard.palette
        , renderCurrentAttempt gameBoard.currentAttempt
        , renderLog gameBoard.log
        ]


renderPalette : Palette -> Html msg
renderPalette palette =
    div [] (text "Palette: " :: List.map renderPaletteBox palette)


renderCurrentAttempt : Attempt -> Html msg
renderCurrentAttempt attempt =
    renderAttempt attempt


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
            Css.border3 (px 10) solid (rgb 0 0 0)

        NoBorder ->
            Css.borderStyle none


renderPaletteBox : DataModel.Color -> Html msg
renderPaletteBox color =
    renderBox
        [ toBorderStyle NoBorder
        , backgroundColor (colorToRgb color)
        ]


renderAttemptBox : DataModel.ColorSpot -> Html msg
renderAttemptBox color =
    renderBox
        [ toBorderStyle BlackBorder
        , backgroundColor (colorSpotToRgb color)
        ]


renderBox : List Style -> Html msg
renderBox styles =
    div
        [ css
            (List.append styles
                [ display inlineBlock
                , width (px 25)
                , height (px 25)
                ]
            )
        ]
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
