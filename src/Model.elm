module Model (..) where

type alias Model = { newTask : String, tasks : List String }

type Action = Noop | UpdateNewTask String | SaveNewTask | Delete Int

model : Model
model =
  { newTask = "", tasks = [] }
