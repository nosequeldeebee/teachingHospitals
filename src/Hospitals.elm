module Hospitals exposing (..)

import Http
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msgs exposing (Msg)
import Models exposing (..)
import RemoteData exposing (WebData)


view : List Hospital -> String -> Html Msg
view refreshedHospitals key =
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
            , tbody [] (List.map (hospitalRow key) refreshedHospitals)
            ]
        ]


hospitalRow : String -> Hospital -> Html Msg
hospitalRow key hospital =
    tr []
        [ td [] [ text hospital.name ]
        , td [] [ text hospital.address ]
        , td [] [ text hospital.city ]
        , td [] [ text hospital.state ]
        , td [] [ text hospital.zip ]
        , a [ href (processLink hospital.address hospital.city hospital.state key), target "_blank" ] [ (img [ src "map.png" ] []) ]
        ]


processLink : String -> String -> String -> String -> String
processLink address city state key =
    let
        fixedAddress =
            String.map replaceSpace address

        fixedCity =
            String.map replaceSpace city

        fixedState =
            String.map replaceSpace state
    in
        String.concat [ "https://maps.googleapis.com/maps/api/staticmap?center=", fixedAddress, "+", fixedCity, "+", fixedState, "&zoom=13&size=600x300&maptype=roadmap&key=", key ]


replaceSpace : Char -> Char
replaceSpace c =
    if c == ' ' then
        '+'
    else
        c
