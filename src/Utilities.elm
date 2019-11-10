module Utilities exposing (count, isJust)


isJust : Maybe a -> Bool
isJust maybe =
    case maybe of
        Just _ ->
            True

        Nothing ->
            False


count : (a -> Bool) -> List a -> Int
count fn list =
    List.length (List.filter fn list)
