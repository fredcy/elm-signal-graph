module Main (..) where

import Html
import Html.Attributes
import Html.Events exposing (on, targetValue)
import Task
import Effects
import StartApp


type alias Model =
  String


init : ( Model, Effects.Effects Action )
init =
  ( "", Effects.none )


type Action
  = NoOp
  | Update String


update : Action -> Model -> ( Model, Effects.Effects Action )
update action model =
  case action of
    NoOp ->
      ( model, Effects.none )
    Update str ->
      ( str, Effects.none )

view : Signal.Address Action -> Model -> Html.Html
view address model =
  Html.div
    []
    [ Html.input [ on "input" targetValue (Signal.message address << Update) ] []
    , Html.div [ ] [ Html.text model ]
    ]


app : StartApp.App Model
app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = []
    }


port tasks : Signal (Task.Task Effects.Never ())
port tasks =
  app.tasks


main : Signal Html.Html
main =
  app.html
