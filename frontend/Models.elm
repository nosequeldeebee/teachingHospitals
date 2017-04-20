module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { initialHospitals : List Hospital
    , refreshedHospitals : List Hospital
    }


initialModel : Model
initialModel =
    { initialHospitals = []
    , refreshedHospitals = []
    }


type alias Hospital =
    { name : String
    , address : String
    , city : String
    , state : String
    , zip : String
    }
