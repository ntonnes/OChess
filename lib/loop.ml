open Tsdl
open Constants

let event_loop win rend =    
  gs := Board.new_game ();         
  let e = Sdl.Event.create () in                                                                 
  let rec loop () = 
    match Sdl.wait_event (Some e) with              
    | Error (`Msg e) -> Sdl.log_error 1 " Could not wait event: %s" e; () 
    | Ok () ->
      Sdl.log "%a" Log.pp_event e;
      match Sdl.Event.(enum (get e typ)) with  (* match on the type of the event *)
      | `Quit -> ()                            (* break *)
<<<<<<< HEAD
      | `Window_event -> Draw.refresh_window win rend (!gs); loop ()
=======
      | `Window_event -> Draw.refresh_window win rend; loop ()
>>>>>>> a6eff91 (implemented buggy capture functionality; need to implement checking path)
      | `Mouse_button_down -> 
        let x, y = Sdl.Event.(get e mouse_button_x, get e mouse_button_y) in
        if Sdl.Event.(get e mouse_button_button) = Sdl.Button.left then
          Click.process win x y rend ;
        loop ()
      | _ -> loop ()                           (* continue to next event *)
  in
  loop ()   
;;
