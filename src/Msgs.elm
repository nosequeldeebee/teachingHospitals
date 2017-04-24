module Msgs exposing (..)

import Models exposing (Hospital, Key)
import RemoteData exposing (WebData)


type Msg
    = OnFetchHospitals (WebData (List Hospital))
    | OnFetchKeys (WebData (List Key))
    | Change String
    | SortName
    | SortAddress
    | SortCity
    | SortState
    | SortZip
    | NextPage
