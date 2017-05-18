module WebResponse exposing (..)

import RemoteData exposing (WebData)
import Models exposing (Model, Hospital)


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
