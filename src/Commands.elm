module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
<<<<<<< Updated upstream
import Models exposing (Hospital, Key)
=======
import Models exposing (..)
>>>>>>> Stashed changes
import RemoteData


fetchHospitals : Cmd Msg
fetchHospitals =
    Http.get fetchHospitalsUrl hospitalsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchHospitals


fetchKeys : Cmd Msg
fetchKeys =
    Http.get fetchKeysUrl keysDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchKeys


fetchHospitalsUrl : String
fetchHospitalsUrl =
    "http://localhost:3001/hospitals"


fetchKeysUrl : String
fetchKeysUrl =
    "http://localhost:4001/google-api-key-boat-house"


hospitalsDecoder : Decode.Decoder (List Hospital)
hospitalsDecoder =
    Decode.list hospitalDecoder


keysDecoder : Decode.Decoder (List Key)
keysDecoder =
    Decode.list keyDecoder


hospitalDecoder : Decode.Decoder Hospital
hospitalDecoder =
    decode Hospital
        |> required "name" Decode.string
        |> required "address" Decode.string
        |> required "city" Decode.string
        |> required "state" Decode.string
        |> required "zip" Decode.string


keyDecoder : Decode.Decoder Key
keyDecoder =
    decode Key
        |> required "key" Decode.string
