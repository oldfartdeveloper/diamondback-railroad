module Game exposing (..)

import Html
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Window
import Board
import ControlPanel
import Sequence


type alias WindowWidth =
  Int


type alias WindowHeight =
  Int


type alias Model =
  { windowWidth : WindowWidth
  , windowHeight : WindowHeight
  ,
  }
  ( WindowWidth, WindowHeight, Board, Sequence )



-- Will have to add Board below


init : ( Model, Effects Action )
init =
  ( Window.width
  , Window.height
  , Sequence.init
  )
