module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model, Hospital)
import RemoteData exposing (WebData)
import Random exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchHospitals response ->
            ( { model | initialHospitals = updateInitial response, refreshedHospitals = updateInitial response, searchedHospitals = updateInitial response }, Cmd.none )

        Msgs.Change keyword ->
            ( { model | refreshedHospitals = List.filterMap (refresh keyword) model.initialHospitals, searchedHospitals = List.filterMap (refresh keyword) model.initialHospitals, index = 10 }, Cmd.none )

        Msgs.SortName ->
            ( { model | searchedHospitals = List.sortBy .name model.initialHospitals, refreshedHospitals = List.sortBy .name model.initialHospitals, index = 10 }, Cmd.none )

        Msgs.SortAddress ->
            ( { model | searchedHospitals = List.sortBy .address model.initialHospitals, refreshedHospitals = List.sortBy .address model.initialHospitals, index = 10 }, Cmd.none )

        Msgs.SortCity ->
            ( { model | searchedHospitals = List.sortBy .city model.initialHospitals, refreshedHospitals = List.sortBy .city model.initialHospitals, index = 10 }, Cmd.none )

        Msgs.SortState ->
            ( { model | searchedHospitals = List.sortBy .state model.initialHospitals, refreshedHospitals = List.sortBy .state model.initialHospitals, index = 10 }, Cmd.none )

        Msgs.SortZip ->
            ( { model | searchedHospitals = List.sortBy .zip model.initialHospitals, refreshedHospitals = List.sortBy .zip model.initialHospitals, index = 10 }, Cmd.none )

        Msgs.NextPage ->
            ( { model | refreshedHospitals = List.take (model.index + 10) model.searchedHospitals, index = model.index + 10 }, Cmd.none )


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
