{-
   This defines what the Caesar page will look like.
-}


module View.Caesar exposing (caesarView)

import Cypher.CaesarCypher exposing (caesarEncrypt)
import Element exposing (Attribute, Color, Element, alignBottom, alignLeft, centerX, centerY, column, el, fill, fillPortion, height, maximum, newTabLink, none, padding, paddingEach, paragraph, px, rgb, row, spacing, text, textColumn, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Model exposing (..)
import Msg exposing (Msg(..))
import View.Navbar exposing (navbar)


backgroundRgba : Color
backgroundRgba =
    Element.rgba 255 255 255 0.8


caesarView : Model -> Element Msg
caesarView model =
    el
        [ width fill, height fill, Background.image "src/img/caesar_background.jpg", padding 50 ]
        (column
            [ Background.color backgroundRgba, width fill, height fill, padding 40, spacing 20 ]
            [ navbar model

            -- title
            , el
                [ height (fillPortion 5), centerX, Font.size 80 ]
                (text "Caesar Cipher")

            -- explains the caesar cypher
            , textColumn
                [ height (fillPortion 3), width (fill |> maximum 800), centerX, spacing 15 ]
                [ el
                    [ Font.size 45
                    , bigLetterPadding
                    , alignLeft
                    ]
                    (text "I")
                , paragraph []
                    [ text "n cryptography, a Caesar cipher is one of the simplest and most widely known encryption techniques. The method is named after Julius Caesar, who used it in his private correspondence."
                    , newTabLink [ Font.size 10, Font.color (rgb 0 0 238) ]
                        { url = "https://en.wikipedia.org/wiki/Caesar_cipher"
                        , label = text "[src]"
                        }
                    ]
                , paragraph []
                    [ text "In this implementation, all you need to do is type in your plaintext and the key, and you can choose whether or not to encrypt or decrypt the text"
                    ]
                ]

            -- input fields
            {--}
            , row
                [ centerX, spacing 10, centerX ]
                -- inputs for the plain text and the key. somehow Input.text doesn't work so I'll use username lol
                [ Input.text
                    [ width (px 200) ]
                    { onChange = CaesarPlaintext
                    , text = model.caesarModel.plainText
                    , placeholder = Nothing
                    , label = Input.labelAbove [] (text "Plaintext")
                    }

                --the input is a string but we'll change it to a number in the update function
                , Input.text
                    [ width (px 200) ]
                    { onChange = CaesarKey
                    , text = String.fromInt model.caesarModel.key
                    , placeholder = Nothing
                    , label = Input.labelAbove [] (text "Key")
                    }

                -- button where you encrypt lol
                , Input.button
                    [ padding 15, Border.width 1, alignBottom ]
                    { onPress = Just EncryptCaesar
                    , label = text "Encrypt"
                    }

                -- button where you decrypt lol
                , Input.button
                    [ padding 15, Border.width 1, alignBottom ]
                    { onPress = Just DecryptCaesar
                    , label = text "Decrypt"
                    }
                ]

            -- outputs the encrypted text
            , if model.caesarModel.cypheredText == "" then
                el [ height (px 100) ] none

              else
                el
                    [ centerX, padding 20, Font.size 60 ]
                    (text model.caesarModel.cypheredText)
            ]
        )



-- this makes every padding 0 except for the right one which is 10


bigLetterPadding : Attribute Msg
bigLetterPadding =
    paddingEach
        { top = 0
        , right = 10
        , bottom = 0
        , left = 0
        }
