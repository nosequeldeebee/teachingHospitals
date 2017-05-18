module Models exposing (..)

import Paginate exposing (..)


type alias Model =
    { initialHospitals : List Hospital
    , refreshedHospitals : PaginatedList Hospital
    , searchedHospitals : List Hospital
    , key : String
    }


type alias Hospital =
    { name : String
    , address : String
    , city : String
    , state : String
    , zip : String
    }
