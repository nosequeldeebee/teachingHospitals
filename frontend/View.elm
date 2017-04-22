module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msgs exposing (Msg)
import Models exposing (Model)
import Hospitals


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Search", onInput Msgs.Change ] []
        , page model
        ]


page : Model -> Html Msg
page model =
    Hospitals.view model.refreshedHospitals
