open Tsdl
open Draw
open Click
open Win


(* 
   Function: event_loop
   Initiates the event loop for handling user inputs and updating the game state.
   Returns: unit
*)
let event_loop () =

  (* Initialize new game pieces and the event to wait on in the loop *)
  new_game (); 
  let e = Sdl.Event.create () in
  
  (* Helper functions to make things more readable *)
  let mb_down () = 
    let x, y = Sdl.Event.(get e mouse_button_x, get e mouse_button_y) in
    if Sdl.Event.(get e mouse_button_button) = Sdl.Button.left 
      then process x y
  in  
  let event_type ()= Sdl.Event.(enum (get e typ)) in
  let next_event ()= Sdl.wait_event (Some e) in

  (* Main event loop *)
  let rec loop () = 
    match next_event () with              
    | Error (`Msg e) -> Sdl.log_error 1 " Error while waiting for event: %s" e; () 
    | Ok () ->
      Sdl.log "%a" Log.pp_event e;
      match event_type () with  
      | `Quit -> ()                            
      | `Window_event -> refresh (); loop ()
      | `Mouse_button_down -> mb_down (); loop ()
      | _ -> loop ()                           
  in
  loop ()   
;;
