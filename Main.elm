import Html exposing (..)
import Html.Attributes exposing (..)
import StartApp.Simple as StartApp

main =
  StartApp.start { model = model, view = view, update = update }

update action model =
  model

model : List String
model =
  [ "walk the dogs", "kill rats", "drop a deuce" ]

view address model =
  section [ class "todoapp" ]
    [ header [ class "header" ]
      [ h1 []
        [ text "todos" ]
      , input [ class "new-todo", placeholder "What needs to be done?" ]
        []
      ]
    , section [ class "main", attribute "style" "display: block;" ]
      [ input [ class "toggle-all", id "toggle-all", type' "checkbox" ]
        []
      , label [ for "toggle-all" ]
        [ text "Mark all as complete" ]
      , ul [ class "todo-list" ]
        (todoItems model)
      ]
    , footer [ class "footer", attribute "style" "display: block;" ]
      [ span [ class "todo-count" ]
        [ strong []
          [ text (toString (List.length model)) ]
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

taskView : String -> Html
taskView task =
  li [ class "completed" ]
    [ div [ class "view" ]
      [ input [ checked False, class "toggle", type' "checkbox" ]
        []
      , label []
        [ text task ]
      , button [ class "destroy" ]
        []
      ]
    , input [ class "edit", value task ]
      []
    ]

todoItems : List String -> List Html
todoItems tasks =
  List.map taskView tasks
