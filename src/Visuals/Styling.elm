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
        , margin2 (px 2) auto
        , backgroundColor (rgb 236 200 170)
        , backgroundImage (linearGradient2 toTopLeft (stop <| rgb 210 190 165) (stop <| rgb 255 222 190) [])
        , borderRadius (px 15)
        , padding (px 20)
        , minHeight (px 768)
        , touchAction manipulation
        , boxShadow3 (px 2) (px 2) (rgb 0 0 0)
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


styleSpot : Maybe PinColor -> Attribute msg
styleSpot maybeColor =
    case maybeColor of
        Just color ->
            stylePin color

        Nothing ->
            styleEmptySpot


stylePin : PinColor -> Attribute msg
stylePin color =
    css
        [ border3 (px 0) solid (rgb 0 0 0)
        , backgroundImage (linearGradient2 toTopLeft (stop <| colorToRgb color) (stop <| secondaryColorToRgb color) [])
        , borderRadius (px 50)
        , margin (px 5)
        , width (px 75)
        , height (px 75)
        , boxShadow3 (px 2) (px 2) (rgb 0 0 0)
        ]


styleEmptySpot : Attribute msg
styleEmptySpot =
    css
        [ backgroundColor (rgb 0 0 0)
        , border3 (px 25) solid (rgb 148 90 37)
        , width (px 25)
        , height (px 25)
        , borderRadius (px 50)
        , margin (px 5)
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


styleCongratulationsMessage : Attribute msg
styleCongratulationsMessage =
    let
        w =
            600

        h =
            100

        fs =
            50
    in
    css
        [ position fixed
        , top (pct 50)
        , left (pct 50)
        , width (px w)
        , height (px h)
        , marginLeft (px (-0.5 * w))
        , marginTop (px (-0.5 * h))
        , fontSize (px fs)
        , fontFamily cursive
        , backgroundColor transparent
        ]



{- [ General helper styles -}


colorToRgb : PinColor -> Color
colorToRgb color =
    case color of
        Red ->
            rgb 200 0 0

        Blue ->
            rgb 0 0 200

        Green ->
            rgb 0 200 0

        Yellow ->
            rgb 200 200 0

        Grey ->
            rgb 125 125 125


secondaryColorToRgb : PinColor -> Color
secondaryColorToRgb color =
    case color of
        Red ->
            rgb 255 100 100

        Blue ->
            rgb 100 100 255

        Green ->
            rgb 100 255 100

        Yellow ->
            rgb 255 255 100

        Grey ->
            rgb 175 175 175
