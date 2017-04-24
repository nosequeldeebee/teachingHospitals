module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { initialHospitals : List Hospital
    , refreshedHospitals : List Hospital
    , searchedHospitals : List Hospital
    , apikey : List Key
    , index : Int
    }


initialModel : Model
initialModel =
    { initialHospitals = []
    , refreshedHospitals = []
    , searchedHospitals = []
    , apikey = []
    , index = 10
    }


type alias Hospital =
    { name : String
    , address : String
    , city : String
    , state : String
    , zip : String
    }


type alias Key =
    { key : String }
