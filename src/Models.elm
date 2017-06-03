module Models exposing (..)

import Paginate exposing (..)


type alias Model =
    { initialHospitals : List Hospital
    , refreshedHospitals : PaginatedList Hospital
    , key : String
    , reverseName : Bool
    , reverseCity : Bool
    , reverseState : Bool
    }


type alias Hospital =
    { name : String
    , address : String
    , city : String
    , state : String
    , zip : String
    }
