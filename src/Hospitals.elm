module Hospitals exposing (..)

import Http
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msgs exposing (Msg)
import Models exposing (..)
import RemoteData exposing (WebData)


-- Table columns and rows with loaded hospital info from memory


view : List Hospital -> String -> Html Msg
view refreshedHospitals key =
    div []
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ p [ onClick Msgs.SortName, style [ ( "cursor", "pointer" ) ] ] [ text "Name" ] ]
                    , th [] [ p [] [ text "Address" ] ]
                    , th [] [ p [ onClick Msgs.SortCity, style [ ( "cursor", "pointer" ) ] ] [ text "City" ] ]
                    , th [] [ p [ onClick Msgs.SortState, style [ ( "cursor", "pointer" ) ] ] [ text "State" ] ]
                    , th [] [ p [] [ text "Zip" ] ]
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
        , iframe [ src (processLink hospital.name hospital.address hospital.city hospital.state key) ] []
        ]



--Create Google Maps Emped API call


processLink : String -> String -> String -> String -> String -> String
processLink name address city state key =
    let
        fixedName =
            String.map replaceSpace name

        fixedAddress =
            String.map replaceSpace address

        fixedCity =
            String.map replaceSpace city

        fixedState =
            String.map replaceSpace state
    in
        if key == "" then
            ""
        else
            String.concat
                [ "https://www.google.com/maps/embed/v1/place?key="
                , key
                , "&q="
                , fixedName
                , "+"
                , fixedAddress
                , "+"
                , fixedCity
                , "+"
                , fixedState
                ]


replaceSpace : Char -> Char
replaceSpace c =
    if c == ' ' then
        '+'
    else
        c
