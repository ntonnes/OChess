open Tsdl
open Globals
open Pieces
open Sidebar
open Win
open Utils


(* 
   Function: render_chessboard
   Renders the background chessboard.
   Returns: unit
*)
let render_chessboard () = 
  let board = load_tex "./assets/board.png" in
  let rect = Sdl.Rect.create
    ~x:!offset_x ~y:!offset_y
    ~w:(!cs * 8) ~h:(!cs * 8)
  in
  paste_tex board rect;
;;


(* 
   Function: new_piece
   Creates a new SDL.Rect representing a chess piece at the specified location.
   Parameters:
     - row: The row on the chess board
     - col: The column on the chess board
   Returns: SDL.Rect
*)
let new_piece row col = 
  let cs = !cs in
  Sdl.Rect.create
  ~x:((col*cs) + (cs/10) + !offset_x) 
  ~y:((row*cs) + (cs/10) + !offset_y) 
  ~w:(cs - (cs/5)) ~h:(cs - (cs/5)) 
;;


(* 
   Function: render_texture
   Renders a single chess piece based on its type and location.
   Parameters:
     - piece: The chess piece to be rendered
   Returns: unit
*)
let render_pieces () = 
  let go piece =
    let tex = load_tex (file_of_piece piece) in
    let rect = new_piece !(piece.row) !(piece.col) in
    paste_tex tex rect;
  in
  List.iter (go) !gs
;;


(* 
   Function: render_selected
   Renders the selected piece by highlighting its position with a green rectangle.
   Returns: unit
*)
let render_selected () =
  let get_rect p = 
    let y, x = !(p.row)*(!cs), !(p.col)*(!cs)in
    Sdl.Rect.create
      ~x:(x + !offset_x) 
      ~y:(y + !offset_y) 
      ~w:!cs ~h:!cs
  in
  match !selected with
  | None -> ()
  | Some p -> draw_rect 0 255 0 70 (get_rect p);
;;


(* 
   Function: render_pieces
   Renders all pieces in the current game state.
   Returns: unit
*)
let render_game () =
  render_chessboard();
  render_selected();
  render_pieces();
;;


(* 
   Function: refresh
   Re-renders the board and all pieces, updating the display.
   Returns: unit
*)
let refresh () =
  
  (* update constants related to window size if necessary *)
  let (w, h) = (!window_w, !window_h) in
  if Sdl.get_window_size (get_window ()) <> (w, h) 
    then update_constants();
  
  render_game();
  render_sidebars();

  let rend = get_rend() in
  Sdl.render_present rend;

  match !victor with
  | None -> ()
  | Some c -> winner c
;;


