module Level
    exposing
        ( Model
        , init
        )


type alias Model =
    { maxPosLength : Int
    }


init : Model
init =
    { maxPosLength =
        11
    }
