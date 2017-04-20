module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msgs exposing (Msg)
import Models exposing (Model)
import Hospitals


view : Model -> Html Msg
view model =
    div [ class "jumbotron" ]
        [ div [] [ text "Teaching Hospitals" ]
        , input [ type_ "text", placeholder "type here...", onInput Msgs.Change ] []
        , div [] [ text model.filteredHospitals ]
        , page model
        ]


page : Model -> Html Msg
page model =
    Hospitals.view model.hospitals
