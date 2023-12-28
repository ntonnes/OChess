open Tsdl
open Constants
open Img
open Tsdl_image



(* renders the background chessboard *)
let render_chessboard renderer = 

  (* load board image as a texture *)
  let board =
    match (Image.load_texture renderer "./assets/board.png") with
    | Error (`Msg e) -> Sdl.log_error 0 "Create texture error: %s" e; exit 1 
    | Ok board -> board
  in

  (* create rect for the space occupied by the board *)
  let rect = Sdl.Rect.create
    ~x:!offset_x ~y:!offset_y
    ~w:(!cell_size * board_size) ~h:(!cell_size *board_size)
  in

  (* render board texture onto the new rect *)
  Sdl.render_copy renderer board ~dst:rect |> ignore;
;;



(* renders pieces in the current state onto the board *)
let render_pieces renderer game_state =
  List.iter (render_texture renderer) game_state
;;



(* fixes the renderer according to the current window dimensions *)
let refresh_window window renderer game_state =

  let (w, h) = (!window_width, !window_height) in
  if Sdl.get_window_size window <> (w, h) then 
    update_constants window;
    render_chessboard renderer;
    render_pieces renderer game_state;
  Sdl.render_present renderer;
;;

