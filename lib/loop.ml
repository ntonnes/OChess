open Tsdl
open Constants
open Board
open Draw
open Click

let event_loop win rend =    
  gs := new_game ();         
  let e = Sdl.Event.create () in                                                                 
  let rec loop () = 
    match Sdl.wait_event (Some e) with              
    | Error (`Msg e) -> Sdl.log_error 1 " Could not wait event: %s" e; () 
    | Ok () ->
      Sdl.log "%a" Log.pp_event e;
      match Sdl.Event.(enum (get e typ)) with  (* match on the type of the event *)
      | `Quit -> ()                            (* break *)
      | `Window_event -> refresh_window win rend; loop ()
      | `Mouse_button_down -> 
        let x, y = Sdl.Event.(get e mouse_button_x, get e mouse_button_y) in
        if Sdl.Event.(get e mouse_button_button) = Sdl.Button.left then
          process win x y rend ;
        loop ()
      | _ -> loop ()                           (* continue to next event *)
  in
  loop ()   
;;
