open Tsdl
open Globals
open Pieces
open Tsdl_image
open Sidebar
open Win
open Captures


(* 
   Function: new_piece
   Creates a new SDL.Rect representing a chess piece at the specified location.
   Parameters:
     - row: The row on the chess board
     - col: The column on the chess board
   Returns: SDL.Rect
*)
let new_piece row col = Sdl.Rect.create 
  ~x:((col * !cell_size) + (!cell_size/10) + !offset_x) 
  ~y:((row * !cell_size) + (!cell_size/10) + !offset_y) 
  ~w:(!cell_size - (!cell_size/5)) 
  ~h:(!cell_size - (!cell_size/5)) 
;;


(* 
   Function: render_chessboard
   Renders the background chessboard.
   Returns: unit
*)
let render_chessboard () = 

  (* Load board image as a texture *)
  let rend = get_rend() in
  let board =
    match (Image.load_texture rend "./assets/board.png") with
    | Error (`Msg e) -> Sdl.log_error 0 "Create texture error: %s" e; exit 1 
    | Ok board -> board
  in

  (* Create rect for the space occupied by the board *)
  let rect = Sdl.Rect.create
    ~x:!offset_x ~y:!offset_y
    ~w:(!cell_size * board_size) ~h:(!cell_size *board_size)
  in

  (* Render board texture onto the new rect *)
  Sdl.render_copy rend board ~dst:rect |> ignore;
  Sdl.destroy_texture board;
;;


(* 
   Function: render_texture
   Renders a single chess piece based on its type and location.
   Parameters:
     - piece: The chess piece to be rendered
   Returns: unit
*)
let render_texture piece = 
  let rend = get_rend() in

  (* load corresponding image as a texture *)
  let tex = match Image.load_texture rend ("./assets/"^(string_of_piece piece)^".png") with
    | Error (`Msg e) -> Sdl.log_error 0 "Create texture error: %s" e; exit 1 
    | Ok tex -> tex
  in

  (* create rect at piece's location *)
  let rect = new_piece !(piece.row) !(piece.col) in

  (* render texture into the new rect *)
  Sdl.render_copy rend tex ~dst:rect |> ignore;
  Sdl.destroy_texture tex;
;;


(* 
   Function: render_selected
   Renders the selected piece by highlighting its position with a green rectangle.
   Returns: unit
*)
let render_selected () =
  let rend = get_rend() in
  let color p = 
    let (row, col) = (!(p.row), !(p.col)) in
    let rect = Sdl.Rect.create
      ~x:((col * !cell_size) + !offset_x) 
      ~y:((row * !cell_size) + !offset_y) 
      ~w:!cell_size
      ~h:!cell_size 
    in
    Sdl.set_render_draw_color rend 0 255 0 255 |> ignore;
    Sdl.render_fill_rect rend (Some rect) |> ignore;
  in
  match !selected with
  | None -> ()
  | Some p -> color p
;;

(* 
   Function: render_pieces
   Renders all pieces in the current game state.
   Returns: unit
*)
let render_pieces () =
  List.iter (render_texture) !gs
;;


(* 
   Function: refresh
   Re-renders the board and all pieces, updating the display.
   Returns: unit
*)
let refresh () =
  let rend = get_rend() in
  let (w, h) = (!window_w, !window_h) in
  if Sdl.get_window_size (get_window ()) <> (w, h) 
    then update_constants();
  
  render_chessboard();
  render_sidebars();
  render_selected();
  render_pieces();
  render_turn_text();
  render_captures_text();
  render_captures();
  Sdl.render_present rend;
  match !victor with
  | None -> ()
  | Some c -> winner c
;;


