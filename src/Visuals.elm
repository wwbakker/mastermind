module Visuals exposing (..)

import Css exposing (Style, backgroundColor, display, height, inlineBlock, none, px, rgb, solid, width)
import DataModel exposing (..)
import Html.Styled exposing (Html, button, div, text)
import Html.Styled.Attributes exposing (css, disabled)
import Html.Styled.Events exposing (onClick)
import Logic



--import Logic exposing (..)
--renderGameBoardUnstyled : GameBoard -> VirtualDom.Node msg
--renderGameBoardUnstyled gameBoard =
--    toUnstyled (renderGameBoard gameBoard)


renderGameBoard : GameBoard -> Html Logic.Msg
renderGameBoard gameBoard =
    div
        [ css
            [ Css.displayFlex
            , Css.flexDirection Css.column
            ]
        ]
        [ renderPalette gameBoard.palette
        , renderAttemptAndSubmitButton gameBoard
        , renderLog gameBoard.log
        ]


renderAttemptAndSubmitButton : GameBoard -> Html Logic.Msg
renderAttemptAndSubmitButton gameBoard =
    div
        []
        [ renderCurrentAttempt gameBoard.currentAttempt
        , renderSubmitButton gameBoard
        ]


renderSubmitButton : GameBoard -> Html Logic.Msg
renderSubmitButton gameBoard =
    button
        [ onClick Logic.Submit
        , disabled (not (Logic.isAttemptValid gameBoard.currentAttempt))
        , css [ Css.flex (Css.int 1) ]
        ]
        [ text "submit" ]


renderPalette : Palette -> Html Logic.Msg
renderPalette palette =
    div [] (text "Palette: " :: List.map renderPaletteBox palette)


renderCurrentAttempt : Attempt -> Html Logic.Msg
renderCurrentAttempt attempt =
    div
        [ css
            [ Css.displayFlex
            , Css.flexDirection Css.row
            , Css.alignItems Css.stretch
            , Css.width (Css.pct 100)
            , Css.height (Css.em 5)
            ]
        ]
        (List.indexedMap renderCurrentAttemptBox attempt)


renderAttempt : Attempt -> Html Logic.Msg
renderAttempt attempt =
    div
        [ css [ display inlineBlock ] ]
        (List.map renderAttemptBox attempt)


renderPastAttempt : PastAttempt -> Html Logic.Msg
renderPastAttempt pastAttempt =
    div [] [ renderAttempt pastAttempt.attempt, renderGrade pastAttempt.grade ]


renderGrade : Grade -> Html msg
renderGrade grade =
    div
        [ css [ display inlineBlock ] ]
        (List.append
            (List.repeat grade.colorAndPositionMatches (text "✔"))
            (List.repeat grade.colorOnlyMatches (text "♦"))
        )


renderLog : Log -> Html Logic.Msg
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
        , Css.flex (Css.int 1)
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
