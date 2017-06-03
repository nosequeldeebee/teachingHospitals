module Msgs exposing (..)

import Http
import Models exposing (Hospital)
import RemoteData exposing (WebData)


type Msg
    = OnFetchHospitals (WebData (List Hospital))
    | NewKey (Result Http.Error String)
    | Change String
    | SortName
    | SortCity
    | SortState
    | Prev
    | Next
    | First
    | Last
