module View exposing (view)

import Element exposing (Element, FocusStyle)
import Element.Font as Font
import GithubLogo
import Html exposing (Html)
import Model exposing (Directory(..), Model)
import Msg exposing (Msg(..))
import View.Caesar exposing (caesarView)
import View.Hash exposing (hashView)
import View.Home exposing (homeView)
import View.Viginere exposing (viginereView)



-- I MADE EVERYTHING MONOSPACE AHHH THE CRINGE
-- but basically this checks the model for the directory and changes the view accordingly.


view : Model -> Html Msg
view model =
    Element.layoutWith
        { options = [ Element.focusStyle focusStyle ] }
        [ Font.family
            [ Font.monospace ]
        , GithubLogo.view
            { href = "https://github.com/joshuanianji/Cryptography"
            , bgColor = "#000"
            , bodyColor = "#fff"
            }
            |> Element.el
                [ Element.alignRight
                , Element.alignTop
                ]
            |> Element.inFront
        ]
    <|
        case model.directory of
            HomePage ->
                homeView model

            CaesarPage ->
                caesarView model

            ViginerePage ->
                viginereView model

            HashPage ->
                hashView model



-- this makes all the buttons not have that ugly blue border. uncomment this and change the view function so it'll not have the options = [ Element.focusStyle focusStyle ], and change layoutWith to layout. It'll be so much uglier lol.


{--}
focusStyle : FocusStyle
focusStyle =
    { borderColor = Nothing
    , backgroundColor = Nothing
    , shadow = Nothing
    }
--}
