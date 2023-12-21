open Tsdl
open Chess

(* Keeps the main window open until closed *)
let event_loop renderer =
  Draw.draw_chessboard renderer;                    (* draws chessboard in the empty renderer *)
  Draw.draw_pieces renderer Board.new_board; (* draws pieces in current game state in the renderer *)
  Sdl.render_present renderer;                      (* presents renderer in the application window *)
  
  let e = Sdl.Event.create () in                                    (* initialize empty event... *)                                   
  let rec loop () = match Sdl.wait_event (Some e) with              (* wait for an event to occur... *)
  | Error (`Msg e) -> Log.log_err " Could not wait event: %s" e; () (* handle error *)
  | Ok () ->
      Log.log "%a" Log.pp_event e;             (* print event info to terminal *)
      match Sdl.Event.(enum (get e typ)) with  (* match on the type of the event *)
      | `Quit -> ()                            (* break *)
      | _ -> loop ()                           (* continue to next event *)
  in
  loop ()   

  
(* Main application *)
let main () = match Sdl.init Sdl.Init.(video + events) with                              (* try to initialize application *)

  | Error (`Msg e) -> Log.log "Init error: %s" e; exit 1
  | Ok () -> match Sdl.create_window ~w:800 ~h:800 "Noah's Chess" Sdl.Window.opengl with (* try to create an empty window *)

    | Error (`Msg e) -> Log.log "Create window error: %s" e; exit 1 
    | Ok w -> match Sdl.create_renderer w with                                           (* try to create an empty renderer *)

      | Error (`Msg e) -> Log.log "Create renderer error: %s" e; exit 1
      | Ok renderer ->                                                                   
        event_loop renderer;                                                             (* pass empty renderer to event loop *)

        (* close application *)
        Sdl.destroy_renderer renderer; 
        Sdl.destroy_window w;
        Sdl.quit ();
        exit 0


(* Runs on execution *)
let () = main ()