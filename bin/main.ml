open Tsdl
open Chess

(* Loop that handles all events from the user *)              
let event_loop window renderer game_state =                
  let e = Sdl.Event.create () in                                                                    
  let rec loop () = 
    match Sdl.wait_event (Some e) with              
    | Error (`Msg e) -> Sdl.log_error 1 " Could not wait event: %s" e; () 
    | Ok () ->
      Sdl.log "%a" Log.pp_event e;
      match Sdl.Event.(enum (get e typ)) with  (* match on the type of the event *)
      | `Quit -> ()                            (* break *)
      | `Window_event -> Draw.refresh_window window renderer game_state; loop ()
      (*| `Mouse_button_down -> Click.get_piece mouse_pos*)
      | _ -> loop ()                           (* continue to next event *)
  in
  loop ()   
;;

;;

(* Main application *)
let main () = match Sdl.init Sdl.Init.(video + events) with                        (* try to initialize application *)

  | Error (`Msg e) -> Sdl.log_error 0 "Init error: %s" e; exit 1
  | Ok () -> match Sdl.create_window ~w:800 ~h:800 "OChess" Sdl.Window.opengl with (* try to create an empty window *)

    | Error (`Msg e) -> Sdl.log_error 0 "Create window error: %s" e; exit 1 
    | Ok window -> match Sdl.create_renderer window with                           (* try to create an empty renderer *)

      | Error (`Msg e) -> Sdl.log_error 0 "Create renderer error: %s" e; exit 1
      | Ok renderer ->

        let game_state = Board.new_game () in (* initialize the internal game *)
        
        Draw.refresh_window window renderer game_state;
        event_loop window renderer game_state; (* enter event loop *)                       

        (* close application *)
        Sdl.destroy_renderer renderer; 
        Sdl.destroy_window window;
        Sdl.quit ();
        exit 0


(* Runs on execution *)
let () = main ()