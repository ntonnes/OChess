open Tsdl

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
      | `Mouse_button_down -> 
        let x, y = Sdl.Event.(get e mouse_button_x, get e mouse_button_y) in
        if Sdl.Event.(get e mouse_button_button) = Sdl.Button.left then
          Click.process window game_state x y renderer;
        loop ()
      | _ -> loop ()                           (* continue to next event *)
  in
  loop ()   
;;
