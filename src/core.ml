open Tea.App
open Tea.Html

type point = float * float

type node = { label: string; pos: point }

type msg =
  | Rename of string 
  | Move of point 
  [@@bs.deriving {accessors}]

let init () = { label = "Cr"; pos = (100.0, 100.0) }

(* This is the central message handler, it takes the model as the first argument *)
let update model = function (* These should be simple enough to be self-explanatory, mutate the model based on the message, easy to read and follow *)
  | Rename s -> { model with label = s }
  | Move p -> { model with pos = p }

  (* This is just a helper function for the view, a simple function that returns a button based on some argument *)
let atom { label; pos=(x,y) } =
  div
    []
    [ span [] [ text label ];
      span [] [ text (string_of_float x) ]
    ]

(* This is the main callback to generate the virtual-dom.
  This returns a virtual-dom node that becomes the view, only changes from call-to-call are set on the real DOM for efficiency, this is also only called once per frame even with many messages sent in within that frame, otherwise does nothing *)
let view model =
  div
    []
    [ atom model ]

let main =
  beginnerProgram { (* The beginnerProgram just takes a set model state and the update and view functions *)
    model = init (); (* Since model is a set value here, we call our init function to generate that value *)
    update;
    view;
  }

let () = 
  let app = main (Web.Document.getElementById "b") in
  app ()
  |> ignore
