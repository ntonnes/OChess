open Tsdl
open Pieces
open Constants



let get_piece renderer cell = 
  let set_color renderer r g b a = Sdl.set_render_draw_color renderer r g b a |> ignore in
  
  match cell with
  | None -> false
  | Some (Pawn _) -> set_color renderer 255 0 0 255;true  (* pawn = red *)
  | Some (Rook _) -> set_color renderer 0 0 255 255;true (* rook = blue *)  
  | Some (Bishop _) -> set_color renderer 0 255 0 255;true (* bishop = green *)
  | Some (Knight _) -> set_color renderer 255 255 0 255;true (* knight = yellow *)
  | Some (Queen _) -> set_color renderer 128 0 128 255;true (* queen = purple *)
  | Some (King _) -> set_color renderer 255 165 0 255;true (* king = orange *)
;;


let render_chessboard renderer = 
  for row = 0 to 7 do
    for col = 0 to 7 do

      (* draw board square *)
      let rect = Sdl.Rect.create 
        ~x:((col * !cell_size) + !offset_x) 
        ~y:((row * !cell_size) + !offset_y) 
        ~w:!cell_size 
        ~h:!cell_size 
      in

      if (row + col) mod 2 = 0 then
        Sdl.set_render_draw_color renderer 255 206 158 255 |> ignore
      else
        Sdl.set_render_draw_color renderer 209 139 71 255 |> ignore;
      Sdl.render_fill_rect renderer (Some rect) |> ignore;
      
    done
  done
;;


let render_pieces renderer game_state =
let render_pieces renderer game_state =
  for row = 0 to 7 do
    for col = 0 to 7 do

      (* render piece within cell *)
      let rect = Sdl.Rect.create 
        ~x:((col * !cell_size)+10+ !offset_x) 
        ~y:((row * !cell_size)+10+ !offset_y) 
        ~w:(!cell_size-20) 
        ~h:(!cell_size-20) 
      in

      let cell = (game_state).(row).(col) in
      if get_piece renderer cell then Sdl.render_fill_rect renderer (Some rect) |> ignore
    
    done
  done
;;

let refresh_window window renderer game_state =

  let (w, h) = (!window_width, !window_height) in
  if Sdl.get_window_size window <> (w, h) then update_constants window; render_chessboard renderer;
  render_pieces renderer game_state;
  Sdl.render_present renderer;
;;

