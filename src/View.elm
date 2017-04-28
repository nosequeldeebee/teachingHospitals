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
        , page model model.key
        , br [] []
        , button [ onClick Msgs.NextPage ] [ text "Load More" ]
        ]



-- Hospitals data called in a separate function for code cleanliness


page : Model -> String -> Html Msg
page model key =
    Hospitals.view (List.take model.index model.refreshedHospitals) key
