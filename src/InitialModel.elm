module InitialModel exposing (..)

import RemoteData exposing (WebData)
import Models exposing (..)
import WebResponse exposing (..)
import Paginate exposing (..)


initialModel : Model
initialModel =
    { initialHospitals = []
    , refreshedHospitals =
        Paginate.fromList 1 <|
            updateInitial RemoteData.Loading
    , searchedHospitals = []
    , key = ""
    }
