module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msgs exposing (Msg)
import Models exposing (Model)
import Hospitals
import Paginate exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Search", onInput Msgs.Change ] []
        , page model model.key
        , br [] []
        , div [ style [ ( "text-align", "center" ) ] ]
            [ button
                [ onClick Msgs.First
                , disabled <|
                    Paginate.isFirst model.refreshedHospitals
                ]
                [ text "<" ]
            , button
                [ onClick Msgs.Prev
                , disabled <|
                    Paginate.isFirst model.refreshedHospitals
                ]
                [ text "Prev" ]
            , button
                [ onClick Msgs.Next
                , disabled <|
                    Paginate.isLast model.refreshedHospitals
                ]
                [ text "Next" ]
            , button
                [ onClick Msgs.Last
                , disabled <|
                    Paginate.isLast model.refreshedHospitals
                ]
                [ text ">" ]
            ]
        ]



-- Hospitals data called in a separate function for code cleanliness


page : Model -> String -> Html Msg
page model key =
    Hospitals.view (Paginate.page model.refreshedHospitals) key
