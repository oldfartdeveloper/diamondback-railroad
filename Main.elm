module Main exposing (main)


import Html.App as Html
import Console exposing (..)


main =
   Html.program
       { init = init
       , view = view
       , update = update
       , subscriptions = subscriptions
       }
