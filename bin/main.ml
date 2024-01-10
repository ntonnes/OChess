open Tsdl
open Tsdl_ttf
open Chess

(* Main application *)
let main () = 

  (* Initialize SDL with required components *)
  match Sdl.init Sdl.Init.(video + events + audio) with                        
  | Error (`Msg e) -> Sdl.log_error 0 "Init error: %s" e; exit 1
  | Ok () -> 
    
    (* Create an SDL window with OpenGL support *)
    match Sdl.create_window ~w:1200 ~h:800 "OChess" Sdl.Window.opengl with 
    | Error (`Msg e) -> Sdl.log_error 0 "Create window error: %s" e; exit 1 
    | Ok windw -> 
      Globals.window := (Some windw);
      
      (* Create an SDL renderer for the window *)
      match Sdl.create_renderer windw with                           
      | Error (`Msg e) -> Sdl.log_error 0 "Create renderer error: %s" e; exit 1
      | Ok renderer ->
        Globals.rend := (Some renderer);

        match Ttf.init () with
        | Error (`Msg e) -> Sdl.log "SDL_ttf initialization error: %s" e; exit 1
        | Ok () ->
        
          (* Enter the main event loop of the application *)
          Loop.event_loop ();
          
          (* Clear memory upon exiting event loop*)                      
          Sdl.destroy_renderer renderer; 
          Sdl.destroy_window windw;
          Sdl.quit ();
          exit 0

(* Runs on execution *)
let () = main ()