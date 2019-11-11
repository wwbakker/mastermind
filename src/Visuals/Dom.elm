module Visuals.Dom exposing (renderFooter, renderGameBoard)

import DataModel exposing (..)
import Html.Styled exposing (Html, a, button, div, text)
import Html.Styled.Attributes exposing (disabled, href, target)
import Html.Styled.Events exposing (onClick)
import Logic
import Visuals.Styling exposing (..)



--import Logic exposing (..)
--renderGameBoardUnstyled : GameBoard -> VirtualDom.Node msg
--renderGameBoardUnstyled gameBoard =
--    toUnstyled (renderGameBoard gameBoard)


renderGameBoard : GameBoard -> Html Logic.Msg
renderGameBoard gameBoard =
    div
        [ styleGameBoard ]
        [ renderPalette gameBoard.palette
        , renderAttemptAndSubmitButton gameBoard
        , renderLog gameBoard.log
        ]


renderAttemptAndSubmitButton : GameBoard -> Html Logic.Msg
renderAttemptAndSubmitButton gameBoard =
    div
        [ styleAttemptAndSubmitButton ]
        [ renderCurrentAttempt gameBoard.currentAttempt
        , renderSubmitButton gameBoard
        ]


renderCurrentAttempt : Attempt -> Html Logic.Msg
renderCurrentAttempt attempt =
    div
        [ styleCurrentAttempt ]
        (List.indexedMap renderCurrentAttemptPin attempt)


renderSubmitButton : GameBoard -> Html Logic.Msg
renderSubmitButton gameBoard =
    button
        [ onClick Logic.Submit
        , disabled (not (Logic.isAttemptValid gameBoard.currentAttempt))
        , styleSubmitButton
        ]
        [ text "submit" ]


renderPalette : Palette -> Html Logic.Msg
renderPalette palette =
    div [ stylePalette ] (List.map renderPaletteBox palette)


renderPastAttempt : PastAttempt -> Html Logic.Msg
renderPastAttempt pastAttempt =
    div [ stylePastAttempt ] [ renderAttempt pastAttempt.attempt, renderGrade pastAttempt.grade ]


renderAttempt : Attempt -> Html Logic.Msg
renderAttempt attempt =
    div
        [ styleAttempt ]
        (List.map renderAttemptPin attempt)


renderGrade : Grade -> Html msg
renderGrade grade =
    div
        [ styleGrade ]
        (List.append
            (List.repeat grade.colorAndPositionMatches renderColorAndPositionMatchBox)
            (List.repeat grade.colorOnlyMatches renderColorOnlyMatch)
        )


renderColorAndPositionMatchBox : Html msg
renderColorAndPositionMatchBox =
    div [ styleColorAndPositionMatch ] [ text "✔" ]


renderColorOnlyMatch : Html msg
renderColorOnlyMatch =
    div [ styleColorOnlyMatch ] [ text "♦" ]


renderLog : Log -> Html Logic.Msg
renderLog log =
    div [ styleLog ] (List.map renderPastAttempt log)


renderPaletteBox : PinColor -> Html Logic.Msg
renderPaletteBox color =
    div
        [ stylePaletteBox color
        , onClick (Logic.PaintColor color)
        ]
        []


renderAttemptPin : DataModel.ColorSpot -> Html msg
renderAttemptPin color =
    renderPin
        (styleAttemptBox color)
        []


renderCurrentAttemptPin : Logic.Index -> DataModel.ColorSpot -> Html Logic.Msg
renderCurrentAttemptPin index color =
    renderPin
        (styleCurrentAttemptPin color)
        [ onClick (Logic.EraseColor index) ]


renderPin : Html.Styled.Attribute msg -> List (Html.Styled.Attribute msg) -> Html msg
renderPin styles otherAttributes =
    div
        (List.append
            [ stylePin
            , styles
            ]
            otherAttributes
        )
        []


renderFooter : Html msg
renderFooter =
    div
        [ styleFooter ]
        [ renderFooterItem "https://github.com/wwbakker/mastermind" "Source code"
        , renderFooterItem "https://www.youtube.com/watch?v=dMHxyulGrEk" "Rules video"
        ]


renderFooterItem : String -> String -> Html msg
renderFooterItem link caption =
    div
        [ styleFooterItem ]
        [ a
            [ href link
            , target "_blank"
            ]
            [ text caption ]
        ]
