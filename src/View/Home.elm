module View.Home exposing (homeView)

import Element exposing (Color, Element, centerX, centerY, column, el, fill, fillPortion, height, newTabLink, padding, rgb, row, text, width)
import Element.Background as Background
import Element.Font as Font
import Model exposing (Model)
import Msg exposing (Msg(..))
import View.Navbar exposing (navbar)


backgroundRgba : Color
backgroundRgba =
    Element.rgba 255 255 255 0.8



{- our home page is divided into a couple main categories.

   we have our background which is the image, with a padding so the child element doens't take up the whole page.

   this child element if the white rectangle which our content is built upon. it is a column function which stack the Navbar, the main title page and the sentence on the bottom with it.

   tbh most of the code comes from the sentence at the bottom where I had to make a link beside the text so ended up making a row lol with a link and the text kms.

   UPDATE: I'm stupid I should have used paragraph now el. Whatever I'll change it later.

    I had to use `el [ height (fillPortion 5) ] Element.none` to push the elements back so it would seem like the title page is centered but actually isn't because centerY doesn't work smh rip.

-}


homeView : Model -> Element Msg
homeView model =
    el
        [ width fill, height fill, Background.image "src/img/home_background.jpg", padding 50 ]
        (column
            [ Background.color backgroundRgba, width fill, height fill, padding 40 ]
            [ navbar model
            , el [ height (fillPortion 5) ] Element.none
            , el
                [ height (fillPortion 5), centerX, Font.size 80 ]
                (text "CRYPTOGRAPHY")
            , el
                [ height (fillPortion 4), centerX, Font.size 20 ]
                (row
                    []
                    [ text "Made with love by Joshua Ji and "
                    , newTabLink
                        [ Font.color (rgb 0 0 238) ]
                        { url = "https://elm-lang.org/"
                        , label = text "the Elm Language"
                        }
                    ]
                )
            ]
        )
