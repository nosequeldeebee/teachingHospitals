module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { hospitals : WebData (List Hospital)
    , filteredHospitals : String
    }


initialModel : Model
initialModel =
    { hospitals = RemoteData.Loading
    , filteredHospitals = ""
    }


type alias Hospital =
    { name : String
    , address : String
    , city : String
    , state : String
    , zip : String
    }
