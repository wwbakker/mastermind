module Visuals.Styling exposing (..)

import Css exposing (..)
import DataModel exposing (PinColor(..))
import Html.Styled exposing (Attribute)
import Html.Styled.Attributes exposing (css)


styleGameBoard : Attribute msg
styleGameBoard =
    css
        [ displayFlex
        , flexDirection column
        , maxWidth (px 980)
        , margin auto
        , backgroundColor (rgb 236 200 170)
        , borderRadius (px 15)
        , padding (px 20)
        , minHeight (px 768)
        , touchAction manipulation
        ]


{-| Palette
-}
stylePalette : Attribute msg
stylePalette =
    css
        [ displayFlex
        , flexDirection row
        , justifyContent spaceAround
        ]


stylePaletteBox : PinColor -> Attribute msg
stylePaletteBox color =
    css
        [ width (px 75)
        , height (px 75)
        , borderStyle none
        , flex (int 1)
        , backgroundColor (colorToRgb color)
        , margin (px 10)
        , borderRadius (px 3)
        ]


{-| AttemptAndSubmitButton -- Contains CurrentAttempt + SubmitButton
-}
styleAttemptAndSubmitButton : Attribute msg
styleAttemptAndSubmitButton =
    css
        [ displayFlex
        , flexDirection row
        , alignItems stretch
        , backgroundColor (rgb 159 105 52)
        , borderRadius (px 15)
        ]


styleCurrentAttempt : Attribute msg
styleCurrentAttempt =
    css
        [ displayFlex
        , flexDirection row
        , justifyContent center
        , flex (int 3)
        ]


styleCurrentAttemptPin : Maybe PinColor -> Attribute msg
styleCurrentAttemptPin color =
    css
        [ border3 (px 5) solid (rgb 0 0 0)
        , backgroundColor (colorSpotToRgb color)
        ]


styleSubmitButton : Attribute msg
styleSubmitButton =
    css
        [ flex (int 1)
        , borderBottomRightRadius (px 15)
        , borderTopRightRadius (px 15)
        , backgroundColor transparent
        , fontSize xxLarge
        , color (rgb 175 175 175)
        , enabled
            [ color (rgb 255 255 255)
            , backgroundColor (rgb 194 131 68)
            ]
        , borderStyle none
        , borderLeft3 (px 2) solid (rgb 255 255 255)
        , padding (px 0)
        ]


{-| Log -- Contains list of PastAttempts
-}
styleLog : Attribute msg
styleLog =
    css
        [ displayFlex
        , flexDirection column
        ]


{-| PastAttempt -- Contains Attempt + Grade
-}
stylePastAttempt : Attribute msg
stylePastAttempt =
    css
        [ displayFlex
        , flexDirection row
        , borderBottom3 (px 1) dashed (rgb 255 255 255)
        ]


styleAttempt : Attribute msg
styleAttempt =
    css
        [ displayFlex
        , flexDirection row
        , justifyContent center
        , flex (int 3)
        ]


styleAttemptBox : Maybe PinColor -> Attribute msg
styleAttemptBox color =
    css
        [ backgroundColor (colorSpotToRgb color)
        ]


styleGrade : Attribute msg
styleGrade =
    css
        [ displayFlex
        , flexDirection row
        , flexWrap wrap
        , flex (int 1)
        , alignItems center
        ]


styleColorAndPositionMatch : Attribute msg
styleColorAndPositionMatch =
    css
        [ fontSize (px 50)
        , color (rgb 0 100 13)
        ]


styleColorOnlyMatch : Attribute msg
styleColorOnlyMatch =
    css
        [ fontSize (px 50)
        , margin2 (px 0) (px 5)
        , color (rgb 255 140 0)
        ]



{- [ Footer - Contains FooterItem -}


styleFooter : Attribute msg
styleFooter =
    css
        [ position fixed
        , bottom (px 0)
        , displayFlex
        , flexDirection row
        , justifyContent center
        , width (pct 100)
        ]


styleFooterItem : Attribute msg
styleFooterItem =
    css [ margin2 (px 0) (px 25) ]



{- [ General helper styles -}


stylePin : Attribute msg
stylePin =
    css
        [ display inlineBlock
        , width (px 75)
        , height (px 75)
        , borderWidth (px 5)
        , borderStyle solid
        , borderColor (rgb 0 0 0)
        , borderRadius (px 50)
        , margin (px 5)
        ]


colorSpotToRgb : Maybe PinColor -> Color
colorSpotToRgb colorSpot =
    case colorSpot of
        Just color ->
            colorToRgb color

        Nothing ->
            rgb 255 255 255


colorToRgb : PinColor -> Color
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
