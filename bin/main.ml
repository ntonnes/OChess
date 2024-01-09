open Tsdl
open Chess

(* Main application *)
let main () = 

  match Sdl.init Sdl.Init.(video + events + audio) with                        (* try to initialize application *)
  | Error (`Msg e) -> Sdl.log_error 0 "Init error: %s" e; exit 1
  | Ok () -> 
    
    match Sdl.create_window ~w:800 ~h:800 "OChess" Sdl.Window.opengl with (* try to create an empty window *)
    | Error (`Msg e) -> Sdl.log_error 0 "Create window error: %s" e; exit 1 
    | Ok windw -> 
      Globals.window := (Some windw);

      match Sdl.create_renderer windw with                           (* try to create an empty renderer *)
      | Error (`Msg e) -> Sdl.log_error 0 "Create renderer error: %s" e; exit 1
      | Ok renderer ->
        Globals.rend := (Some renderer);
        
        Loop.event_loop (); (* enter event loop *)                       
        (* close application *)
        Sdl.destroy_renderer renderer; 
        Sdl.destroy_window windw;
        Sdl.quit ();
        exit 0


(* Runs on execution *)
let () = main ()