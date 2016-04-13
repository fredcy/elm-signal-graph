module Main (..) where

import Html
import Html.Attributes exposing (value)
import Html.Events exposing (on, targetValue)
import Task
import Effects
import StartApp
import Mouse


type alias Model =
  String


init : ( Model, Effects.Effects Action )
init =
  ( "", Effects.none )


type Action
  = NoOp
  | Update String
  | Click


update : Action -> Model -> ( Model, Effects.Effects Action )
update action model =
  case action of
    NoOp ->
      ( model, Effects.none )

    Update str ->
      ( str, Effects.none )

    Click ->
      ( model ++ "X", Effects.none )


view : Signal.Address Action -> Model -> Html.Html
view address model =
  Html.div
    []
    [ Html.input
        [ on "input" targetValue (Signal.message address << Update)
        , value model
        ]
        []
    , Html.div [] [ Html.text model ]
    ]


app : StartApp.App Model
app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = [ Mouse.clicks |> Signal.map (always Click) ]
    }


port tasks : Signal (Task.Task Effects.Never ())
port tasks =
  app.tasks


main : Signal Html.Html
main =
  app.html
