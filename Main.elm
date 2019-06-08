module Main exposing (main)

import Browser
import Model exposing (..)
import Msg exposing (..)
import Update exposing (update)
import View exposing (view)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }



-- initializes everything to blank strings, 0's and Sha224 in the case of the hash lol


initModel : Model
initModel =
    { directory = HomePage
    , caesarModel = CaesarModel "" 0 ""
    , viginereModel = ViginereModel "" "" ""
    , test = ""
    , hashModel = HashModel "" Sha224 ""
    }


init : () -> ( Model, Cmd Msg )
init () =
    ( initModel, Cmd.none )
