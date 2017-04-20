module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model)
import RemoteData exposing (WebData)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchHospitals response ->
            ( { model | hospitals = response }, Cmd.none )

        Msgs.Change change ->
            ( { model | filteredHospitals = "barney" }, Cmd.none )
