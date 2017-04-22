module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { initialHospitals : List Hospital
    , refreshedHospitals : List Hospital
    , searchedHospitals : List Hospital
    , index : Int
    }


initialModel : Model
initialModel =
    { initialHospitals = []
    , refreshedHospitals = []
    , searchedHospitals = []
    , index = 10
    }


type alias Hospital =
    { name : String
    , address : String
    , city : String
    , state : String
    , zip : String
    }
