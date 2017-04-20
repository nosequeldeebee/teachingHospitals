module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Msgs exposing (Msg)
import Models exposing (Model)
import Hospitals


view : Model -> Html Msg
view model =
    div [ class "jumbotron" ]
        [ page model
        ]


page : Model -> Html Msg
page model =
    Hospitals.view model.hospitals
