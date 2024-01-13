open Tsdl
open Draw
open Click
open Win


(** [event_loop ()] is the main event loop for the chess game.
    Initializes new game pieces and waits for SDL events in a loop.
    The loop processes different types of events like quitting, window events, and mouse button clicks.
    The loop continues until the user quits or an error occurs.
    @raise [Sdl_error] if there is an error while waiting for an event.
*)
let event_loop () =

  (* Initialize new game pieces and the event to wait on in the loop *)
  new_game (); 
  let e = Sdl.Event.create () in
  
  (* Helper functions to make things more readable *)
  let event_type ()= Sdl.Event.(enum (get e typ)) in
  let next_event ()= Sdl.wait_event (Some e) in

  (* Main event loop *)
  let rec loop () = 
    match next_event () with              
    | Error (`Msg e) -> Sdl.log_error 1 " Error while waiting for event: %s" e; () 
    | Ok () ->
      Sdl.log "%a" Log.pp_event e;
      if game_over() then () else
      match event_type () with  
      | `Quit -> ()                            
      | `Window_event -> refresh (); loop ()
      | `Mouse_button_down -> process_click e; loop ()
      | _ -> loop ()                           
  in
  loop ()   
;;
