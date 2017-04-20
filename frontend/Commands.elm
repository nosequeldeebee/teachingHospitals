module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Models exposing (Hospital)
import RemoteData


fetchHospitals : Cmd Msg
fetchHospitals =
    Http.get fetchHospitalsUrl hospitalsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchHospitals


fetchHospitalsUrl : String
fetchHospitalsUrl =
    "http://localhost:3001/hospitals"


hospitalsDecoder : Decode.Decoder (List Hospital)
hospitalsDecoder =
    Decode.list hospitalDecoder


hospitalDecoder : Decode.Decoder Hospital
hospitalDecoder =
    decode Hospital
        |> required "name" Decode.string
        |> required "address" Decode.string
        |> required "city" Decode.string
        |> required "state" Decode.string
        |> required "zip" Decode.string
