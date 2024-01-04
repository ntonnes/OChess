open Tsdl
open Constants
open Pieces
open Tsdl_image

(*** CREATE CELL RECT AT SPECIFIED LOCATION ***)
let new_piece row col = Sdl.Rect.create 
  ~x:((col * !cell_size) + (!cell_size/10) + !offset_x) 
  ~y:((row * !cell_size) + (!cell_size/10) + !offset_y) 
  ~w:(!cell_size - (!cell_size/5)) 
  ~h:(!cell_size - (!cell_size/5)) 
;;

(*** RENDER BACKGROUND CHESSBOARD ***)
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


(* RENDERS A SINGLE CHESS PIECE *)
let render_texture renderer piece = 

  (* load corresponding image as a texture *)
  let tex = match Image.load_texture renderer ("./assets/"^(string_of_piece piece)^".png") with
    | Error (`Msg e) -> Sdl.log_error 0 "Create texture error: %s" e; exit 1 
    | Ok tex -> tex
  in

  (* create rect at piece's location *)
  let rect = new_piece piece.row piece.col in

  (* render texture into the new rect *)
  Sdl.render_copy renderer tex ~dst:rect |> ignore;
;;


(*** RENDERS ALL PIECES IN CURRENT STATE ***)
let render_pieces renderer game_state =
  List.iter (render_texture renderer) game_state
;;


(*** RE-RENDERS BOARD AND ALL PIECES ***)
let refresh_window window renderer game_state =

  let (w, h) = (!window_width, !window_height) in
  if Sdl.get_window_size window <> (w, h) then 
    update_constants window;
    render_chessboard renderer;
    render_pieces renderer game_state;
  Sdl.render_present renderer;
;;


