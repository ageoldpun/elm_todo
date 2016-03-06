import Array exposing (toList, fromList)
import Char exposing (fromCode)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import StartApp.Simple as StartApp

main =
  StartApp.start { model = model, view = view, update = update }

type Action = UpdateNewTask String | Delete Int
type alias Model = { newTask : String, tasks : List String }

update : Action -> Model -> Model
update action model =
  case action of
    UpdateNewTask task -> { model | newTask = task }
    Delete index ->
      { model | tasks = removeIndex index model.tasks }

removeIndex : Int -> List a -> List a
removeIndex index list =
  (List.take index list) ++ (List.drop (index+1) list)

model : Model
model =
  { newTask = "", tasks = [] }

view address model =
  section [ class "todoapp" ]
    [ header [ class "header" ]
      [ h1 []
        [ text "todos" ]
      , input
        [ on "input" targetValue (\value -> Signal.message address (UpdateNewTask value))
        , class "new-todo"
        , placeholder "What needs to be done?" ]
        []
      ]
    , section [ class "main", attribute "style" "display: block;" ]
      [ input [ class "toggle-all", id "toggle-all", type' "checkbox" ]
        []
      , label [ for "toggle-all" ]
        [ text "Mark all as complete" ]
      , ul [ class "todo-list" ]
        (todoItems address model.tasks)
      ]
    , footer [ class "footer", attribute "style" "display: block;" ]
      [ span [ class "todo-count" ]
        [ strong []
          [ text (toString (List.length model.tasks)) ]
        , text " items left"
        ]
      , ul [ class "filters" ]
        [ li []
          [ a [ class "selected", href "#/" ]
            [ text "All" ]
          ]
        , li []
          [ a [ href "#/active" ]
            [ text "Active" ]
          ]
        , li []
          [ a [ href "#/completed" ]
            [ text "Completed" ]
          ]
        ]
      , button [ class "clear-completed" ]
        [ text "Clear completed" ]
      ]
    ]

taskView address index task =
  li []
    [ div [ class "view" ]
      [ input [ checked False, class "toggle", type' "checkbox" ]
        []
      , label []
        [ text task ]
      , button [ onClick address (Delete index), class "destroy" ]
        []
      ]
    , input [ class "edit", value task ]
      []
    ]

todoItems address tasks =
  List.indexedMap (taskView address) tasks
