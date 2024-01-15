open Tsdl
open Tsdl_ttf
open Chess.Utils
open Chess.Loop


(* Main application *)
let main () = 

  (* Initialize SDL with required components *)
  begin match Sdl.init Sdl.Init.(video + events + audio) with                        
  | Error (`Msg e) -> Sdl.log_error 0 "Init error: %s" e; exit 1
  | Ok () -> 
    
    (* Create an SDL window with OpenGL support *)
    begin match Sdl.create_window ~w:1200 ~h:800 "OChess" Sdl.Window.opengl with 
    | Error (`Msg e) -> Sdl.log_error 0 "Create window error: %s" e; exit 1 
    | Ok window -> set_window window;
      
      (* Create an SDL renderer for the window *)
      begin match Sdl.create_renderer window with                           
      | Error (`Msg e) -> Sdl.log_error 0 "Create renderer error: %s" e; exit 1
      | Ok renderer -> set_renderer renderer;

        begin match Ttf.init () with
        | Error (`Msg e) -> Sdl.log "SDL_ttf initialization error: %s" e; exit 1
        | Ok () ->
          
          (* Enter the main event loop of the application *)
          event_loop();

          (* Clear memory and close program when exiting event loop *)                      
          quit_game();

        end
      end
    end
  end
;;


(* Runs on execution *)
let () = main ()