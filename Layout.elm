module Layout
    exposing
        ( Model
        , Msg(..)
        , init
        , update
        , view
        )

{-|
This is a convenient spot to hold
values useful for the layout of the panes, etc.

The values are held here as well as functions
that calculate locating the different components of
    the game.
-}

import Window
import Task
import Html exposing (Html, div, text)
import Html.App
import Board exposing (Location)


type alias Model =
    { windowSize : Window.Size
    , boardSideSize : Int
    , sideSize : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { windowSize =
            Window.Size 0 0
      , boardSideSize =
        0
      , sideSize =
        0
      }
    , Task.perform (\_ -> Idle) (\x -> Resize x) Window.size
    )


type Msg
    = Resize Window.Size
    | Idle
    | ChangeBoardDimensions Location


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Resize newSize ->
            let
                model =
                    updateFromResize model newSize
            in
                ( model
                , Cmd.none
                )

        Idle ->
            ( model, Cmd.none )

        ChangeBoardDimensions dimensions ->
            let
                model =
                    updateFromBoardChange model newDimensions
            in
                ( model
                , Cmd.none
                )


updateFromResize : Model -> Window.Size -> Model
updateFromResize model newSize =
    -- calculate new layout
    model


updateFromBoardChange : Model -> Location -> Model
updateFromBoardChange model newDimensions =
    -- calculate new layout
    model



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ text "Doin' nuthin' right now"
        ]
