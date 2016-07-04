module ControlPanel
    exposing
        ( Model
        , init
        , update
        , view
        )

import Html exposing (Html, div, text)
import Window
import Task
import Svg exposing (..)
import Svg.Attributes exposing (..)


type alias Model =
    { windowSize : Window.Size
    }


init : Model
init =
    { windowSize = Window.Size 0 0
    }


type Msg
    = Resize Window.Size


update : Msg -> Model -> Model
update msg model =
    case msg of
        Resize newSize ->
            { model
                | windowSize = newSize
            }


view : Model -> Html Msg
view model =
    div
        [ width (toString model.windowSize.width)
        , height (toString model.windowSize.height)
        ]
        [ Html.text "The Control Panel"
        ]
