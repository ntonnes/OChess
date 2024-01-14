open Tsdl
open Globals
open Pieces
open Sidebar
open Win
open Utils
open Check


(** [render_chessboard ()] renders the chessboard texture on the game window.
    Loads the chessboard texture and renders it, adjusted for the window offset.
*)
let render_chessboard () = 
  let board = load_tex "./assets/board.png" in
  let rect = Sdl.Rect.create
    ~x:!offset_x ~y:!offset_y
    ~w:(!cs * 8) ~h:(!cs * 8)
  in
  paste_tex board rect;
;;


(** [new_piece row col] creates a new SDL rectangle representing the position and size of a chess piece on the window.
    @param row The row on the chessboard.
    @param col The column on the chessboard.
    @return An SDL rectangle representing the position and size of the chess piece.
*)
let new_piece row col = 
  let cs = !cs in
  Sdl.Rect.create
  ~x:((col*cs) + (cs/10) + !offset_x) 
  ~y:((row*cs) + (cs/10) + !offset_y) 
  ~w:(cs - (cs/5)) ~h:(cs - (cs/5)) 
;;


(** [render_pieces ()] renders all chess pieces on the game window.
    Iterates through the list of game pieces, loads their textures, and renders them into the window.
*)
let render_pieces () = 
  let go piece =
    let tex = load_tex (file_of_piece piece) in
    let rect = new_piece !(piece.row) !(piece.col) in
    paste_tex tex rect;
  in
  List.iter (go) !gs
;;


(** [render_selected ()] highlights the currently selected chess piece on the game window.
    If a piece is selected, it highlights its cell with a semi-transparent green rectangle.
*)
let render_selected () =
  let highlight_tiles = 
    match !selected with
    | None -> []
    | Some p ->
      let src = (!(p.row), !(p.col)) in
      [src]@(get_valid_moves p)
  in
  let get_rect (row, col) = 
    let y, x = (row * !cs), (col * !cs) in
    Sdl.Rect.create
      ~x:(x + !offset_x) 
      ~y:(y + !offset_y) 
      ~w:!cs ~h:!cs
  in
  List.iter (fun coord -> draw_rect 0 255 0 70 (get_rect coord)) highlight_tiles


(** [render_game ()] renders the entire game on the window.
    It includes rendering the chessboard, selected piece highlight, and all chess pieces.
*)
let render_game () =
  render_chessboard();
  render_selected();
  render_pieces();
;;


(** [refresh ()] refreshes the game window with the latest graphics.
    It checks for window size changes and updates constants accordingly.
    The function then renders the game, sidebars, and presents the SDL renderer.
    If there is a game outcome, it displays the winner.
*)
let refresh () =
  
  let (w, h) = (!window_w, !window_h) in
  if Sdl.get_window_size (get_window ()) <> (w, h) 
    then update_constants();
  
  render_game();
  render_sidebars();
  Sdl.render_present (get_rend());

  match !victor with
  | None -> ()
  | Some c -> winner c
;;


