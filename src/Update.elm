module Update (update) where

import Model exposing (..)

update : Action -> Model -> Model
update action model =
  case action of
    Noop ->
      model

    UpdateNewTask task ->
      { model | newTask = task }

    SaveNewTask ->
      { model | tasks = model.tasks ++ [ model.newTask ], newTask = "" }

    Delete index ->
      { model | tasks = removeIndex index model.tasks }

removeIndex : Int -> List a -> List a
removeIndex index list =
  (List.take index list) ++ (List.drop (index+1) list)
