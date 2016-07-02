{-|
  The level of a particular game.
  This defines layout and rules for a single
  layer of a game.

  Starting out slow here, just to keep Board.elm
  from getting too large, but will move board layout
  here.
-}
module Level
    exposing
      ( init
      )

type alias Model =
    {
      maxPosLength : Int
    }


init : Model
init =
  { maxPosLength =
      11
  }
