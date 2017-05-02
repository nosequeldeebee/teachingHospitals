module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { initialHospitals : List Hospital
    , refreshedHospitals : List Hospital
    , searchedHospitals : List Hospital
    , index : Int
    , key : String
    }


initialModel : Model
initialModel =
    { initialHospitals = []
    , refreshedHospitals =
        [ { name = "Loading...", address = "", city = "", state = "", zip = "" } ]
    , searchedHospitals = []
    , index = 10
    , key = ""
    }


type alias Hospital =
    { name : String
    , address : String
    , city : String
    , state : String
    , zip : String
    }
