module Msg exposing (Msg(..))

import Model exposing (Directory, HashAlgorithm)


type Msg
    = ChangeDirectory Directory
      -- this is for Caesar Cypher
    | CaesarPlaintext String
    | CaesarKey String
    | EncryptCaesar
    | DecryptCaesar
      -- this is used for the Viginere Cypher
    | ViginerePlainText String
    | ViginereKey String
    | EncodeViginere
    | DecodeViginere
    | ViginereIllegalCharacterInput
      -- for the Hash algorithm
    | UpdateHashPlaintext String
    | UpdateHashAlgorithm HashAlgorithm
    | UpdateHashOutput
