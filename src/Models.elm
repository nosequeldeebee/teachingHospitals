module Models exposing (..)

import RemoteData exposing (WebData)
import Paginate exposing (..)


type alias Model =
    { initialHospitals : List Hospital
    , refreshedHospitals : PaginatedList Hospital
    , searchedHospitals : List Hospital
    , key : String
    }


initialModel : Model
initialModel =
    { initialHospitals = []
    , refreshedHospitals =
        Paginate.fromList 10
            [ { name = "Loading...", address = "", city = "", state = "", zip = "" } ]
    , searchedHospitals = []
    , key = ""
    }


type alias Hospital =
    { name : String
    , address : String
    , city : String
    , state : String
    , zip : String
    }
