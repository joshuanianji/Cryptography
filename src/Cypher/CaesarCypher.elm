{- massive shoutout to James Carlson for his code that I shamelessly took inspiration from!!

   https://medium.com/@jxxcarlson/function-pipelines-and-caesars-code-in-elm-3e770a6b3497

-}


module Cypher.CaesarCypher exposing (caesarDecrypt, caesarEncrypt)

import Char


string2ascii message =
    message
        |> String.toList
        |> List.map Char.toCode


ascii2string nums =
    nums
        |> List.map Char.fromCode
        |> String.fromList


add x y =
    x + y


caesarEncrypt k str =
    str
        |> String.toUpper
        |> string2ascii
        |> List.map (add k)
        |> ascii2string



-- do I even need this here??


caesarDecrypt k str =
    caesarEncrypt -k str
