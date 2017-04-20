module Msgs exposing (..)

import Models exposing (Hospital)
import RemoteData exposing (WebData)


type Msg
    = OnFetchHospitals (WebData (List Hospital))
    | FilterHospitals (List (List Hospital))
