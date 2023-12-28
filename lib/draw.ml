open Tsdl
open Pieces
open Constants
open Board



let set_renderer_color renderer piece = 
  let set renderer r g b a = Sdl.set_render_draw_color renderer r g b a |> ignore in
  
  match piece.piece with
  | Pawn -> set renderer 255 0 0 255;  (* pawn = red *)
  | Rook -> set renderer 0 0 255 255; (* rook = blue *)  
  | Bishop -> set renderer 0 255 0 255; (* bishop = green *)
  | Knight -> set renderer 255 255 0 255; (* knight = yellow *)
  | Queen -> set renderer 128 0 128 255; (* queen = purple *)
  | King -> set renderer 255 165 0 255; (* king = orange *)
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

  let render_piece piece = 
    set_renderer_color renderer piece;
    Sdl.render_fill_rect renderer (Some piece.rect) |> ignore;
  in
  List.iter render_piece game_state
;;

let refresh_window window renderer game_state =

  let (w, h) = (!window_width, !window_height) in
  if Sdl.get_window_size window <> (w, h) then 
    update_constants window;
    let game_state = adjust_pieces game_state in
    render_chessboard renderer;
    render_pieces renderer game_state;
  Sdl.render_present renderer;
;;

