module Console
    exposing
        ( init
        , view
        , update
        , subscriptions
        )

{-|
Primary job of the console is to select the
game and coordinate responsive web design
with the control panel.  Hence it holds
values useful for the layout of the panes, etc.

The values are held here as well as functions
that calculate locating the different components of
    the game.
-}

import Html exposing (Html, div, text)
import Html.App
import Task
import Window
import ControlPanel
import Game


type alias Model =
    { controlPanel : ControlPanel.Model
    , game : Game.Model
    , windowSize : Window.Size
    }


init : ( Model, Cmd Msg )
init =
    ( { controlPanel =
            ControlPanel.init
      , game =
            Game.init
      }
    , Task.perform (\_ -> Idle) (\x -> Resize x) Window.size
    )


type Msg
    = Resize Window.Size
    | Idle


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Resize newSize ->
            ( { model
                | windowSize = newSize
              }
            , Cmd.none
            )

        Idle ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ text "Doin' nuthin' right now"
        ]
