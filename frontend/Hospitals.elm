module Hospitals exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msgs exposing (Msg)
import Models exposing (Model, Hospital)
import RemoteData exposing (WebData)


view : List Hospital -> Html Msg
view refreshedHospitals =
    div []
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ button [ onClick Msgs.SortName ] [ text "Name" ] ]
                    , th [] [ button [ onClick Msgs.SortAddress ] [ text "Address" ] ]
                    , th [] [ button [ onClick Msgs.SortCity ] [ text "City" ] ]
                    , th [] [ button [ onClick Msgs.SortState ] [ text "State" ] ]
                    , th [] [ button [ onClick Msgs.SortZip ] [ text "Zip" ] ]
                    ]
                ]
            , tbody [] (List.map hospitalRow refreshedHospitals)
            ]
        ]


hospitalRow : Hospital -> Html Msg
hospitalRow hospital =
    tr []
        [ td [] [ text hospital.name ]
        , td [] [ text hospital.address ]
        , td [] [ text hospital.city ]
        , td [] [ text hospital.state ]
        , td [] [ text hospital.zip ]
        ]
