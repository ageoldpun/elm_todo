module View (view) where

import Array exposing (toList, fromList)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Model exposing (..)
import Update exposing (..)

view : Signal.Address Action -> Model -> Html
view address model =
  section [ class "todoapp" ]
    [ header [ class "header" ]
      [ h1 []
        [ text "todos" ]
      , input
        [ on "input" targetValue (\value -> Signal.message address (UpdateNewTask value))
        , onKeyPress address (\keyCode -> if keyCode == 13 then SaveNewTask else Noop)
        , value model.newTask
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

taskView : Signal.Address Action -> Int -> String -> Html
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

todoItems : Signal.Address Action -> List String -> List Html
todoItems address tasks =
  List.indexedMap (taskView address) tasks
