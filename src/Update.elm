module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model, Hospital)
import RemoteData exposing (WebData)
import Random exposing (..)
import Paginate exposing (..)
import WebResponse exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- Google API key retrieval
        Msgs.NewKey (Ok key) ->
            ( { model | key = key }, Cmd.none )

        Msgs.NewKey (Err error) ->
            ( { model | key = toString error }, Cmd.none )

        -- Hospitals list retrieval from JSON API
        Msgs.OnFetchHospitals response ->
            ( { model
                | initialHospitals = updateInitial response
                , refreshedHospitals =
                    Paginate.fromList 10 <|
                        updateInitial response
              }
            , Cmd.none
            )

        -- When user types search term
        Msgs.Change keyword ->
            ( { model
                | refreshedHospitals =
                    Paginate.fromList 10 <|
                        List.filterMap (refresh keyword) model.initialHospitals
              }
            , Cmd.none
            )

        -- Sorting column headers
        Msgs.SortName ->
            sortName model

        Msgs.SortCity ->
            sortCity model

        Msgs.SortState ->
            sortState model

        -- Navigate Pages
        Msgs.Next ->
            ( { model | refreshedHospitals = Paginate.next model.refreshedHospitals }, Cmd.none )

        Msgs.Prev ->
            ( { model | refreshedHospitals = Paginate.prev model.refreshedHospitals }, Cmd.none )

        Msgs.First ->
            ( { model | refreshedHospitals = Paginate.first model.refreshedHospitals }, Cmd.none )

        Msgs.Last ->
            ( { model | refreshedHospitals = Paginate.last model.refreshedHospitals }, Cmd.none )



--sort by fields and reverse sort if clicked again


sortName : Model -> ( Model, Cmd Msg )
sortName model =
    if model.reverseName == False then
        ( { model
            | refreshedHospitals =
                Paginate.fromList 10 <|
                    List.sortBy .name model.initialHospitals
            , reverseName = True
          }
        , Cmd.none
        )
    else
        ( { model
            | refreshedHospitals =
                Paginate.fromList 10 <|
                    List.reverse (List.sortBy .name model.initialHospitals)
            , reverseName = False
          }
        , Cmd.none
        )


sortCity : Model -> ( Model, Cmd Msg )
sortCity model =
    if model.reverseCity == False then
        ( { model
            | refreshedHospitals =
                Paginate.fromList 10 <|
                    List.sortBy .city model.initialHospitals
            , reverseCity = True
          }
        , Cmd.none
        )
    else
        ( { model
            | refreshedHospitals =
                Paginate.fromList 10 <|
                    List.reverse (List.sortBy .city model.initialHospitals)
            , reverseCity = False
          }
        , Cmd.none
        )


sortState : Model -> ( Model, Cmd Msg )
sortState model =
    if model.reverseState == False then
        ( { model
            | refreshedHospitals =
                Paginate.fromList 10 <|
                    List.sortBy .state model.initialHospitals
            , reverseState = True
          }
        , Cmd.none
        )
    else
        ( { model
            | refreshedHospitals =
                Paginate.fromList 10 <|
                    List.reverse (List.sortBy .state model.initialHospitals)
            , reverseState = False
          }
        , Cmd.none
        )



-- Capitalize search string to match API data format


refresh : String -> Hospital -> Maybe Hospital
refresh keyword h =
    if String.contains (String.toUpper keyword) h.state then
        Just h
    else if String.contains (String.toUpper keyword) h.name && String.length keyword > 2 then
        Just h
    else if String.contains (String.toUpper keyword) h.city && String.length keyword > 2 then
        Just h
    else
        Nothing
