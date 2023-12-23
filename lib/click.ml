(*open Tsdl
open Constants

let get_clicked_cell x y =
  let row = y / !cell_size in
  let col = x / !cell_size in
  if row >= 0 && row < 8 && col >= 0 && col < 8 then Some (row, col) else None

let rec drag_and_drop_loop window renderer game_state source_cell =
  (* Draw the updated board and pieces *)
  Draw.update renderer game_state;
  Sdl.render_present renderer;

  let e = Sdl.Event.create () in
  match Sdl.wait_event (Some e) with
  | Error (`Msg err) ->
    Sdl.log_error 1 "Error while waiting for event: %s" err; ()
  | Ok () ->
    match Sdl.Event.(enum (get e typ)) with
    | `Quit -> ()
    | `Mouse_motion ->
      let x = Sdl.Event.get e Sdl.Event.mouse_motion_x in
      let y = Sdl.Event.get e Sdl.Event.mouse_motion_y in
      let dest_cell = get_clicked_cell x y in
      (match dest_cell with
      | Some _ ->
        (* Draw the piece being dragged *)
        Draw.get_piece renderer (game_state).(fst source_cell).(snd source_cell);
        let rect = Sdl.Rect.create ~x:(x - !cell_size / 2) ~y:(y - !cell_size / 2) ~w:!cell_size ~h:!cell_size in
        Sdl.render_fill_rect renderer (Some rect) |> ignore;
        (* Continue dragging *)
        drag_and_drop_loop window renderer game_state source_cell
      | None -> drag_and_drop_loop window renderer game_state source_cell)
    | _ -> drag_and_drop_loop window renderer game_state source_cell*)
