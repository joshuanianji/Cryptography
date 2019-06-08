-- this module examines every Msg that is sent out and changes the model or makes a command accordingly


module Update exposing (update)

import Cypher.CaesarCypher exposing (caesarDecrypt, caesarEncrypt)
import Cypher.CalculateHash exposing (calculateHash)
import Cypher.ViginereCypher exposing (viginereDecrypt, viginereEncrypt)
import Model exposing (Model)
import Msg exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeDirectory dir ->
            -- literally just changes directory lol. Only manipula data in the Model, but this in turn is read by the View function which then changes the HTML page. Isn't that cool?
            ( { model | directory = dir }, Cmd.none )

        CaesarPlaintext inputText ->
            -- changes the data in model.caesarModel.plainText. Nested type aliases are often a headache but idk how to make a higher order function to help me rip.
            let
                c =
                    model.caesarModel
            in
            ( { model | caesarModel = { c | plainText = inputText } }, Cmd.none )

        CaesarKey inputKey ->
            -- changes data in model.caesarModel.key and model.caesarModel.inputKey
            let
                c =
                    model.caesarModel

                -- if we cannot convert the key to an int we will set the key to its original value. So if they enter a letter the number won't change
                intKey =
                    if inputKey == "" then
                        0

                    else
                        case String.toInt inputKey of
                            Just int ->
                                int

                            Nothing ->
                                model.caesarModel.key
            in
            -- we change the model.caesarModel.inputKey and model.caesarModel.key but not the plaintext and cypheredText
            ( { model
                | caesarModel =
                    Model.CaesarModel
                        model.caesarModel.plainText
                        intKey
                        model.caesarModel.cypheredText
              }
            , Cmd.none
            )

        EncryptCaesar ->
            let
                plainText =
                    model.caesarModel.plainText

                key =
                    model.caesarModel.key

                c =
                    model.caesarModel
            in
            ( { model | caesarModel = { c | cypheredText = caesarEncrypt key plainText } }, Cmd.none )

        -- this is exactly the same thing as encryptCaesar but the key is negative lol
        DecryptCaesar ->
            let
                plainText =
                    model.caesarModel.plainText

                key =
                    model.caesarModel.key

                c =
                    model.caesarModel
            in
            ( { model | caesarModel = { c | cypheredText = caesarDecrypt key plainText } }, Cmd.none )

        ViginerePlainText inputText ->
            -- changes the data in model.viginereModel.plainText.
            let
                c =
                    model.viginereModel
            in
            if onlyLetters inputText then
                ( { model | viginereModel = { c | plainText = String.toUpper inputText } }, Cmd.none )

            else
                update ViginereIllegalCharacterInput model

        ViginereKey inputKey ->
            -- changes the data in model.viginereModel.key.
            let
                c =
                    model.viginereModel
            in
            if onlyLetters inputKey then
                ( { model | viginereModel = { c | key = String.toUpper inputKey } }, Cmd.none )

            else
                update ViginereIllegalCharacterInput model

        EncodeViginere ->
            -- encodes the viginere plainText
            let
                c =
                    model.viginereModel

                encryptedMessage =
                    viginereEncrypt model.viginereModel.plainText model.viginereModel.key
            in
            ( { model | viginereModel = { c | cypheredText = encryptedMessage } }, Cmd.none )

        DecodeViginere ->
            -- decodes the viginere plainText
            let
                c =
                    model.viginereModel

                decryptedMessage =
                    viginereDecrypt model.viginereModel.plainText model.viginereModel.key
            in
            ( { model | viginereModel = { c | cypheredText = decryptedMessage } }, Cmd.none )

        --if the people type in something that's not an alphanumeric character (e.g. letters)
        ViginereIllegalCharacterInput ->
            -- changes the data in model.viginereModel.key.
            let
                c =
                    model.viginereModel
            in
            ( { model | viginereModel = { c | cypheredText = "Letters only!" } }, Cmd.none )

        -- HASH
        UpdateHashAlgorithm algorithm ->
            -- updates the hash's algorithm
            let
                c =
                    model.hashModel
            in
            ( { model | hashModel = { c | algorithm = algorithm } }, Cmd.none )

        UpdateHashOutput ->
            -- calculates hash and puts that into the model
            let
                c =
                    model.hashModel

                text =
                    model.hashModel.plainText
            in
            ( { model | hashModel = { c | outputHash = calculateHash model text } }, Cmd.none )

        UpdateHashPlaintext string ->
            -- updates the hash's algorithm
            let
                c =
                    model.hashModel
            in
            ( { model | hashModel = { c | plainText = string } }, Cmd.none )



-- checks to see if the entire string only contains alphanumeric letters


onlyLetters : String -> Bool
onlyLetters string =
    List.all Char.isAlpha (String.toList string)
