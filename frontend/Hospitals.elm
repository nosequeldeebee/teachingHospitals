module Hospitals exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msgs exposing (Msg)
import Models exposing (Hospital)
import RemoteData exposing (WebData)


view : WebData (List Hospital) -> Html Msg
view response =
    div []
        [ maybeList response
        ]


list : List Hospital -> Html Msg
list hospitals =
    div []
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Name" ]
                    , th [] [ text "Address" ]
                    , th [] [ text "City" ]
                    , th [] [ text "State" ]
                    , th [] [ text "Zip" ]
                    ]
                ]
            , tbody [] (List.map hospitalRow hospitals)
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


maybeList : WebData (List Hospital) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success hospitals ->
            list hospitals

        RemoteData.Failure error ->
            text (toString error)
