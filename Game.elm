module Game
  exposing
    ( Model
    , init
    , update
    , view
    )


import Html exposing (Html, div, text)
import Html.App
import Task


type alias Model =
  { maxPosLength : Int
  }


-- Will have to add Board below


init : Model
init =
  { maxPosLength = 11
  }


type Msg
    = Idle


update : Msg -> Model -> Model
update msg model =
  case msg of
    Idle ->
      model


view : Model -> Html Msg
view model =
  div []
      [ text "Game panel here"]
