module Cypher.CalculateHash exposing (calculateHash)

import Crypto.Hash exposing (..)
import Model exposing (HashAlgorithm(..), Model)



-- uses model to see what the model has for its model.hashModel.algorithm


calculateHash : Model -> String -> String
calculateHash model input =
    case model.hashModel.algorithm of
        Sha224 ->
            sha224 input

        Sha256 ->
            sha256 input

        Sha384 ->
            sha384 input

        Sha512 ->
            sha512 input

        Sha512_224 ->
            sha512_224 input

        Sha512_256 ->
            sha512_256 input
