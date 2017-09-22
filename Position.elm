module Position
    exposing
        ( Model
        , Msg(..)
        , blink
        , init
        , initWithInfo
        , isPerimeter
        , update
        , view
        , PositionType(..)
        )

import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes
    exposing
        ( alignmentBaseline
        , fill
        , fontSize
        , height
        , points
        , stroke
        , strokeWidth
        , textAnchor
        , version
        , viewBox
        , width
        , x
        , y
        )


-- import Color exposing (..)

import Matrix exposing (Location)
import Time exposing (Time, second)
import Debug exposing (log)


-- CONSTANTS


gridFillColor : String
gridFillColor =
    "peru"


blinkFalseColor : String
blinkFalseColor =
    "lightgoldenrodyellow"


blinkTrueColor : String
blinkTrueColor =
    "lightcyan"


visitedColor : String
visitedColor =
    "navajowhite"


borderColor : String
borderColor =
    "saddlebrown"



-- MODEL


type alias Pixels =
    Float


type alias Visited =
    Bool


type PositionType
    = Perimeter
    | Grid


type alias Model =
    { location : Location
    , maxPosLength : Int
    , sideSize : Pixels
    , positionType : PositionType
    , visited : Visited
    , blinkState : Bool
    }


init : ( Model, Cmd Msg )
init =
    let
        model =
            { positionType = Grid
            , maxPosLength = 11
            , location = ( 1, 1 )
            , sideSize = 50
            , visited = False
            , blinkState = False
            }
    in
        ( model, Cmd.none )


initWithInfo : PositionType -> Int -> Pixels -> Location -> ( Model, Cmd Msg )
initWithInfo positionType maxPosLength sideSize location =
    init
        |> (\( model, cmd ) ->
                ( { model
                    | positionType = positionType
                    , maxPosLength = maxPosLength
                    , sideSize = sideSize
                    , location = location
                  }
                , cmd
                )
           )



-- UPDATE


type Msg
    = MarkVisited
    | Tick Time
    | Nothing


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MarkVisited ->
            ( { model
                | visited =
                    True
              }
            , Cmd.none
            )

        Tick newTime ->
            ( model, Cmd.none )

        Nothing ->
            ( model, Cmd.none )


isPerimeter : Model -> Bool
isPerimeter model =
    model.positionType
        == Perimeter


blink : Bool -> Model -> Model
blink newBlinkState model =
    { model | blinkState = newBlinkState }



-- VIEW


view : Model -> Html Msg
view model =
    let
        sideSize =
            model.sideSize

        ( locX, locY ) =
            model.location

        calcPixelsFor position =
            toString (sideSize * (toFloat position))

        whole =
            toString sideSize

        rectangle =
            rect
                [ width whole
                , height whole
                , fill
                    (model
                        |> (\m ->
                                -- determine background color
                                if m.positionType == Grid then
                                    gridFillColor
                                else if m.visited then
                                    visitedColor
                                else if m.blinkState then
                                    blinkTrueColor
                                else
                                    blinkFalseColor
                           )
                    )
                , stroke borderColor
                , strokeWidth (toString (sideSize / 20.0))
                ]
                []
    in
        Svg.svg
            [ version "1.1"
            , x (calcPixelsFor locX)
            , y (calcPixelsFor locY)
            ]
            [ rectangle
            ]
