{-
   the hashView function describes what the hash page will look like
-}


module View.Hash exposing (hashView)

import Element exposing (Attribute, Color, Element, alignBottom, alignLeft, centerX, centerY, column, el, fill, fillPortion, height, maximum, newTabLink, none, padding, paddingEach, paddingXY, paragraph, px, rgb, row, spacing, text, textColumn, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Model exposing (HashAlgorithm(..), Model)
import Msg exposing (Msg(..))
import View.Navbar exposing (navbar)


backgroundRgba : Color
backgroundRgba =
    Element.rgba 255 255 255 0.8


hashView : Model -> Element Msg
hashView model =
    el
        [ width fill, height fill, Background.image "src/img/hash_background.jpg", padding 50 ]
        (column
            [ Background.color backgroundRgba, width fill, height fill, padding 40, spacing 20 ]
            [ navbar model

            -- title
            , el
                [ height (fillPortion 4), centerX, Font.size 80 ]
                (text "Hashing Algorithms")

            -- explains the Hashing
            , textColumn
                [ height (fillPortion 3), width (fill |> maximum 800), centerX, spacing 15 ]
                [ el
                    -- this makes the letter 'A' big, but not does not mess up the formatting of the other paragraphs, because it is treated as a completely different element that is aligned to the left.
                    [ alignLeft
                    , Font.size 45
                    , bigLetterPadding
                    ]
                    (text "A")
                , paragraph []
                    [ text "hash function is any function that can be used to map data of arbitrary size to data of a fixed size. This implementation uses the SHA algorithms. The Secure Hash Algorithms are a family of cryptographic hash functions published by the National Institute of Standards and Technology (NIST) as a U.S. Federal Information Processing Standard (FIPS)"
                    , newTabLink [ Font.size 10, Font.color (rgb 0 0 238) ]
                        { url = "https://en.wikipedia.org/wiki/Hash_function"
                        , label = text "[src]"
                        }
                    ]
                , paragraph []
                    [ text "In this implementation, you will need to type in your plaintext and select the hash algorithm to implement it with. We will return your hashed data."
                    ]
                ]

            -- this contains the plaintext and the hash algorithm. This does not have any height (fillPortion x) because I want it to have its usual height.
            , row
                [ width fill
                , spacing 10
                ]
                [ -- the user puts in their plaintext here
                  Input.multiline
                    [ width fill ]
                    { onChange = UpdateHashPlaintext
                    , text = Debug.log "the current hash plaintext is: " model.caesarModel.plainText
                    , placeholder = Nothing
                    , label = Input.labelAbove [] (text "Plaintext")
                    , spellcheck = False
                    }

                -- encrypt button. the user presses it and we do the hashing
                , Input.button
                    [ padding 25, Border.width 1, alignBottom ]
                    { onPress = Just UpdateHashOutput
                    , label = el [ centerX ] (text ("Hash using " ++ Debug.toString model.hashModel.algorithm ++ " algorithm"))
                    }
                ]

            -- The user selects the algorithm using a radio. Also no height (fillPortion x) because i want it to have its minimal height
            , Input.radioRow
                [ spacing 12
                ]
                { selected = Just model.hashModel.algorithm
                , onChange = UpdateHashAlgorithm
                , label = Input.labelAbove [ Font.size 14, paddingXY 0 12 ] (text "Please select your hash")
                , options =
                    [ Input.option Sha224 (text "Sha224")
                    , Input.option Sha256 (text "Sha256")
                    , Input.option Sha384 (text "Sha384")
                    , Input.option Sha512 (text "Sha512")
                    , Input.option Sha512_224 (text "Sha512_224")
                    , Input.option Sha512_256 (text "Sha512_256")
                    ]
                }

            -- outputs the actual text. fillPortion 3 to get ready for the hash lol
            , textColumn
                [ height (fillPortion 3)
                , padding 20
                , width fill
                , centerY
                ]
                [ el [ centerY ] (text "Your hash:")

                -- i use this so we have a blank space waster when we don't have a hash to output, or else when we update the view with a has it'll shoft everything up a bit
                , if model.hashModel.outputHash == "" then
                    el [ height (px 21) ] none

                  else
                    paragraph [ width fill ] [ text model.hashModel.outputHash ]
                ]
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
