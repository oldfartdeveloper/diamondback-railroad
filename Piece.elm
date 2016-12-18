module Piece
    exposing
        ( Model
        , Msg(..)
        , init
        , initWithInfo
        , update
        , view
        )

-- import Easing exposing (ease, easeOutQuint, float)
-- import Effects exposing (Effects)

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
import Color
import Animation exposing (px)
import Matrix exposing (Location)
import Debug exposing (log)


-- MODEL


type alias Pixels =
    Float


type alias PieceNumber =
    Int


type Role
    = Head
    | Middle
    | Tail
    | Unassigned


type alias Model =
    { role : Role
    , location : Location
    , pieceNumber : PieceNumber
    , sideSize : Pixels
    , styles : List Animation.Property
    }


init : ( Model, Cmd Msg )
init =
    ( { role = Unassigned
      , location = (1, 1)
      , pieceNumber = 1
      , sideSize = 44.0
      , styles = getSvgValues (1, 1) 44.0
      }
    , Cmd.none
    )


initWithInfo : PieceNumber -> Pixels -> Location -> ( Model, Cmd Msg )
initWithInfo pieceNumber_ sideSize_ location_ =
    ( { role = Unassigned
      , location = location_
      , pieceNumber = pieceNumber_
      , sideSize = sideSize_
      , styles =
          getSvgValues location_ sideSize_
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Animation.subscription Animate model.styles


-- UPDATE


type Msg
    = Show
    | Animate Animation.Msg
    | Move Location


onStyle : Model -> (Animation.State -> Animation.State) -> Model
onStyle model styleFn =
    { model | styles = styleFn <| model.styles }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Show ->
            ( model, Cmd.none )

        Animate animMsg ->
            ( { model
                | styles = Animation.update animMsg model.styles
              }
            , Cmd.none
            )

        Move location ->
            let
                newStyles =
                     Animation.interrupt
                        [ Animation.to
                            [ Animation.translate ]
                        ]
                        model.styles
            in
                (
                    { model
                        | styles = newStyles
                    }
                , Cmd.none
                )


moveLoc : Location -> Model -> Model
moveLoc delta model =
    let
        ( dx, dy ) =
            delta

        ( x, y ) =
            model.location

        newLocation =
            ( x + dx, y + dy )
    in
        { model | location = newLocation }


getSvgValues : Location -> Float -> List Animation.Property
getSvgValues location sideSize =
    let
        ( xloc, yloc ) =
            location

        pixelsX =
            sideSize * (toFloat xloc)

        pixelsY =
            sideSize * (toFloat yloc)
    in
        [ Animation.left (px pixelsX)
        , Animation.top  (px pixelsY)
        ]


-- VIEW


edgeThickness : number
edgeThickness =
    3


darkBrown : String
darkBrown =
    "saddlebrown"


renderPiece : Model -> Html Msg
renderPiece model =
    let
        sideSize =
            model.sideSize

        ( locX, locY ) =
            model.location

        edgeRatio =
            (edgeThickness * sideSize) / 100

        plusIndent =
            toString edgeRatio

        minusIndent =
            toString (sideSize - edgeRatio)

        whole =
            toString sideSize

        half =
            toString (sideSize / 2.0)

        narrow =
            toString (sideSize / 10.0)

        textDownMore =
            toString (sideSize / 1.8)

        polyPoints =
            half
                ++ " "
                ++ plusIndent
                ++ ", "
                ++ minusIndent
                ++ " "
                ++ half
                ++ ", "
                ++ half
                ++ " "
                ++ minusIndent
                ++ ", "
                ++ plusIndent
                ++ " "
                ++ half

        polys =
            polygon
                [ fill "white"
                , points polyPoints
                , stroke "indianred"
                , strokeWidth (toString edgeRatio)
                ]
                []

        myText =
            text_
                [ x half
                , y textDownMore
                , fill "black"
                , fontSize "20"
                , alignmentBaseline "middle"
                , textAnchor "middle"
                ]
                [ text (toString model.pieceNumber) ]
    in
        Svg.svg ( Animation.render model.styles)
                [ polys
                , myText
                ]



view : Model -> Html Msg
view model =
    renderPiece model
