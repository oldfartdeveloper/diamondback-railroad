module MainLayout exposing (..)

import Html.App as Html
import Layout exposing (..)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
