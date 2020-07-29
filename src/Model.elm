module Model exposing (CaesarModel, Directory(..), HashAlgorithm(..), HashModel, Model, ViginereModel, hashAlgoToString)

-- my model


type alias Model =
    { directory : Directory
    , caesarModel : CaesarModel
    , viginereModel : ViginereModel
    , test : String
    , hashModel : HashModel
    }


{--}
type alias CaesarModel =
    { plainText : String
    , key : Int
    , cypheredText : String
    }
--}


type alias ViginereModel =
    { plainText : String
    , key : String
    , cypheredText : String
    }


type alias HashModel =
    { plainText : String
    , algorithm : HashAlgorithm
    , outputHash : String
    }



-- uses SHA algorithms


type HashAlgorithm
    = Sha224
    | Sha256
    | Sha384
    | Sha512
    | Sha512_224
    | Sha512_256


hashAlgoToString : HashAlgorithm -> String
hashAlgoToString algo =
    case algo of
        Sha224 ->
            "Sha224"

        Sha256 ->
            "Sha256"

        Sha384 ->
            "Sha384"

        Sha512 ->
            "Sha512"

        Sha512_224 ->
            "Sha512_224"

        Sha512_256 ->
            "Sha512_256"



-- directory


type Directory
    = HomePage
    | CaesarPage
    | ViginerePage
    | HashPage
