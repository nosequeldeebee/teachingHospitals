module Main exposing (..)

import Html exposing (program)
import Msgs exposing (Msg)
import Models exposing (Model)
import InitialModel exposing (initialModel)
import Update exposing (update)
import View exposing (view)
import Commands exposing (fetchHospitals, fetchKey)


-- Load hospitals and Google API key into memory


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.batch [ fetchHospitals, fetchKey ] )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
