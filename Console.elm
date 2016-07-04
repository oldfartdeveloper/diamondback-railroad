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
import Keyboard exposing (KeyCode)
import AnimationFrame
import Time exposing (Time, second, millisecond)
import Matrix exposing (Location)
import Position
import Piece



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
      , windowSize =
            Window.Size 0 0
      }
    , Task.perform (\_ -> Idle) (\x -> Resize x) Window.size
    )


type Msg
    = Resize Window.Size
    | Idle
    | KeyDown KeyCode
    | Animate Time
    | Blink Time
    | ModifyPosition Location Position.Msg
    | ModifyPiece Location Piece.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ModifyPosition location positionMsg ->
            ( model, Cmd.none )

        ModifyPiece location pieceMsg ->
            ( model, Cmd.none )

        KeyDown keyCode ->
            ( model, Cmd.none )

        --            manageKeyDown model keyCode
        Blink time ->
            ( model, Cmd.none )

        --            blinkUnvisitedPerimeterPositions model
        Animate time ->
            ( model, Cmd.none )

        {-
           ( { model
               | chain =
                   (List.map (\piece -> animatePiece piece time)
                       model.chain
                   )
             }
           , Cmd.none
           )
        -}
        Resize newSize ->
            ( { model
                | windowSize = newSize
              }
            , Cmd.none
            )

        Idle ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.downs KeyDown
        , AnimationFrame.times Animate
        , Time.every (700 * Time.millisecond) Blink
        , Window.resizes Resize
        ]


view : Model -> Html Msg
view model =
    div []
        [ text "Doin' nuthin' right now"
        ]
