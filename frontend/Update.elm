module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model, Hospital)
import RemoteData exposing (WebData)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchHospitals response ->
            ( { model | initialHospitals = updateInitial response, refreshedHospitals = updateInitial response }, Cmd.none )

        Msgs.Change keyword ->
            ( { model | refreshedHospitals = List.filterMap (refresh keyword) model.initialHospitals }, Cmd.none )


updateInitial : WebData (List Hospital) -> List Hospital
updateInitial response =
    case response of
        RemoteData.NotAsked ->
            []

        RemoteData.Loading ->
            []

        RemoteData.Failure error ->
            []

        RemoteData.Success hospitals ->
            hospitals


refresh : String -> Hospital -> Maybe Hospital
refresh keyword h =
    if String.contains (String.toUpper keyword) h.name then
        Just h
    else
        Nothing
