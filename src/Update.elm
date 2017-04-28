module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model, Hospital)
import RemoteData exposing (WebData)
import Random exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- Google API key retrieval
        Msgs.NewKey (Ok key) ->
            ( { model | key = key }, Cmd.none )

        Msgs.NewKey (Err error) ->
            ( { model | key = toString error }, Cmd.none )

        -- Hospitals list retrieval from JSON API
        Msgs.OnFetchHospitals response ->
            ( { model | initialHospitals = updateInitial response, refreshedHospitals = updateInitial response, searchedHospitals = updateInitial response }, Cmd.none )

        -- When user types search term
        Msgs.Change keyword ->
            ( { model | refreshedHospitals = List.filterMap (refresh keyword) model.initialHospitals, searchedHospitals = List.filterMap (refresh keyword) model.initialHospitals, index = 10 }, Cmd.none )

        -- Sorting column headers
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

        --Load more data onto page
        Msgs.NextPage ->
            ( { model | refreshedHospitals = List.take (model.index + 10) model.searchedHospitals, index = model.index + 10 }, Cmd.none )


updateInitial : WebData (List Hospital) -> List Hospital
updateInitial response =
    case response of
        RemoteData.NotAsked ->
            [ { name = "", address = "", city = "", state = "", zip = "" } ]

        RemoteData.Loading ->
            [ { name = "Loading...", address = "", city = "", state = "", zip = "" } ]

        RemoteData.Failure error ->
            [ { name = toString error, address = "", city = "", state = "", zip = "" } ]

        RemoteData.Success hospitals ->
            hospitals



-- Capitalize search string to match API data format


refresh : String -> Hospital -> Maybe Hospital
refresh keyword h =
    if String.contains (String.toUpper keyword) h.name then
        Just h
    else
        Nothing
