module View.Viginere exposing (viginereView)

import Element exposing (Attribute, Color, Element, alignBottom, alignLeft, centerX, column, el, fill, fillPortion, height, maximum, newTabLink, none, padding, paddingEach, paragraph, px, rgb, row, spacing, text, textColumn, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Model exposing (Model)
import Msg exposing (Msg(..))
import View.Navbar exposing (navbar)


backgroundRgba : Color
backgroundRgba =
    Element.rgba 255 255 255 0.8


viginereView : Model -> Element Msg
viginereView model =
    el
        [ width fill, height fill, Background.image "src/img/viginere_background.jpg", padding 50 ]
        (column
            [ Background.color backgroundRgba, width fill, height fill, padding 40, spacing 20 ]
            [ navbar model

            -- title
            , el
                [ height (fillPortion 5), centerX, Font.size 80 ]
                (text "Viginere Cipher")

            -- explains the Viginere Cypher
            , textColumn
                [ height (fillPortion 3), width (fill |> maximum 800), centerX, spacing 15 ]
                [ el
                    [ alignLeft
                    , Font.size 45
                    , bigLetterPadding
                    ]
                    (text "T")
                , paragraph []
                    [ text "he Vigenère cipher (French pronunciation: \u{200B}[viʒnɛːʁ]) is a method of encrypting alphabetic text by using a series of interwoven Caesar ciphers, based on the letters of a keyword. It is a form of polyalphabetic substitution."
                    , newTabLink [ Font.size 10, Font.color (rgb 0 0 238) ]
                        { url = "https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher"
                        , label = text "[src]"
                        }
                    ]
                , paragraph []
                    [ text "In this implementation, you will need to type in your key and your message to encode. We will do the rest for you."
                    ]
                ]

            -- The Input fields
            , row
                [ centerX, spacing 10 ]
                -- inputs for the plain text and the key. somehow Input.text doesn't work so I'll use username lol
                [ Input.text
                    []
                    { onChange = ViginerePlainText
                    , text = model.viginereModel.plainText
                    , placeholder = Nothing
                    , label = Input.labelAbove [] (text "Plaintext")
                    }

                --the input is a string but we'll change it to a number in the update function
                , Input.text
                    []
                    { onChange = ViginereKey
                    , text = model.viginereModel.key
                    , placeholder = Nothing
                    , label = Input.labelAbove [] (text "Key")
                    }

                -- encrypt button
                , Input.button
                    [ padding 15, Border.width 1, alignBottom ]
                    { onPress =
                        if model.viginereModel.key == "" then
                            Nothing

                        else
                            Just EncodeViginere
                    , label = el [ centerX ] (text "Encrypt")
                    }

                -- decrypt button
                , Input.button
                    [ padding 15, Border.width 1, alignBottom ]
                    { onPress =
                        if model.viginereModel.key == "" then
                            Nothing

                        else
                            Just DecodeViginere
                    , label = el [ centerX ] (text "Decrypt")
                    }
                ]

            -- outputs the encrypted text
            , if model.viginereModel.cypheredText == "" then
                el [ height (px 100) ] none

              else
                el
                    [ centerX, padding 20, Font.size 60 ]
                    (text model.viginereModel.cypheredText)
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
