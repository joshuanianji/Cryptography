module View.Navbar exposing (navbar)

import Element exposing (Attribute, Element, centerX, el, fill, height, padding, px, row, text, width)
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font
import Element.Input exposing (button)
import List exposing (map)
import Model exposing (Directory(..), Model)
import Msg exposing (Msg(..))



{-

   i'm going to create my Navbar using a mapping over a list to save space.

   First we have a navbarMapList which holds all the data.

   Next we have the navbarFramework that gives out a navbar element when given the tuple that the navbarMapList is constructed out of.

   Navbar framework also has to take in the Model to account for the fact that navbarElementAttributes, the helper function that changes the bolding of the navbar when we're in specific directories, takes in a tuple

   mapping navbarFramework over navbarMapList gives us a list of Element Msg's that we can put in row. This list looks like this:

   [ el [ centerX, width fill, onClick (ChangeDirectory HomePage) ] (text "Home")
   , el [ centerX, width fill, onClick (ChangeDirectory CaesarPage) ] (text "Caesar")
   , el [ centerX, width fill, onClick (ChangeDirectory ViginerePage) ] (text "Viginere")
   , el [ centerX, width fill, onClick (ChangeDirectory HashPage) ] (text "Hash")
   ]

-}


navbarMapList : List ( String, Directory )
navbarMapList =
    [ ( "Home", HomePage )
    , ( "Caesar", CaesarPage )
    , ( "Viginere", ViginerePage )
    , ( "Hash", HashPage )
    ]


navbarFramework : Model -> ( String, Directory ) -> Element Msg
navbarFramework model ( name, directory ) =
    button
        (navbarElementAttributes model directory)
        { onPress = Just (ChangeDirectory directory)
        , label = el [ centerX ] (text name)
        }


navbar : Model -> Element Msg
navbar model =
    row [ width fill ]
        (map
            (navbarFramework model)
            navbarMapList
        )



-- checks to see in the model if we're in that specific directory. if we are we make the text bold.


navbarElementAttributes : Model -> Directory -> List (Attribute Msg)
navbarElementAttributes model dir =
    let
        basicNavBarAttributes =
            [ padding 20, width fill, Border.width 0 ]
    in
    if model.directory == dir then
        Font.bold :: basicNavBarAttributes

    else
        basicNavBarAttributes
