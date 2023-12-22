open Tsdl
open Pieces
open Constants



let get_piece renderer cell = 
  let set_color renderer r g b a = Sdl.set_render_draw_color renderer r g b a |> ignore in
  
  match cell with
  | None -> ()
  | Some (Pawn _) -> set_color renderer 255 0 0 255;()  (* pawn = red *)
  | Some (Rook _) -> set_color renderer 0 0 255 255;() (* rook = blue *)  
  | Some (Bishop _) -> set_color renderer 0 255 0 255;() (* bishop = green *)
  | Some (Knight _) -> set_color renderer 255 255 0 255;() (* knight = yellow *)
  | Some (Queen _) -> set_color renderer 128 0 128 255;() (* queen = purple *)
  | Some (King _) -> set_color renderer 255 165 0 255;() (* king = orange *)



let update renderer game_state =
  for row = 0 to 7 do
    for col = 0 to 7 do

      (* draw board square *)
      let rect = Sdl.Rect.create ~x:(col * cell_size) ~y:(row * cell_size) ~w:cell_size ~h:cell_size in
      if (row + col) mod 2 = 0 then
        Sdl.set_render_draw_color renderer 255 206 158 255 |> ignore
      else
        Sdl.set_render_draw_color renderer 209 139 71 255 |> ignore;
      Sdl.render_fill_rect renderer (Some rect) |> ignore;

      (* render piece within cell *)
      let rect = Sdl.Rect.create ~x:(col * cell_size) ~y:(row * cell_size) ~w:cell_size ~h:cell_size in
      let cell = (game_state).(row).(col) in
      get_piece renderer cell;
      Sdl.render_fill_rect renderer (Some rect) |> ignore (* this just refills with background color if there is no piece*)
    
    done
  done