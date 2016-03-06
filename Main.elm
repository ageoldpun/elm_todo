import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import StartApp.Simple as StartApp

main =
  StartApp.start { model = model, view = view, update = update }

type Action = Add | Delete String

update action model =
  case action of
    Add -> model ++ [""]
    Delete taskToRemove ->
      List.filter (\task -> taskToRemove /= task) model

model : List String
model =
  []

view address model =
  section [ class "todoapp" ]
    [ header [ class "header" ]
      [ h1 []
        [ text "todos" ]
      --, input [ class "new-todo", placeholder "What needs to be done?" ]
      --  []
      , button [ onClick address Add ]
        [ text "Add" ]
      ]
    , section [ class "main", attribute "style" "display: block;" ]
      --[ input [ class "toggle-all", id "toggle-all", type' "checkbox" ]
      --  []
      [ label [ for "toggle-all" ]
        [ text "Mark all as complete" ]
      , ul [ class "todo-list" ]
        (todoItems address model)
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

taskView address task =
  li []
    [ div [ class "view" ]
      [ input [ checked False, class "toggle", type' "checkbox" ]
        []
      , label []
        [ text task ]
      , button [ onClick address (Delete task), class "destroy" ]
        []
      ]
    , input [ class "edit", value task ]
      []
    ]

todoItems address tasks =
  List.map (taskView address) tasks
