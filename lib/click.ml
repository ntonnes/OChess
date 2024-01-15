open Tsdl
open Globals
open Pieces
open Draw
open Validate
open Check
open Win


(** [cell_of_pixel x y] converts pixel coordinates to chessboard cell coordinates.
    @param x The x-coordinate of the pixel.
    @param y The y-coordinate of the pixel.
    @return A tuple representing the row and column of the corresponding chessboard cell.
*)
let cell_of_pixel x y : (int * int) = 
  let col = (x - !offset_x) / !cs in
  let row = (y - !offset_y) / !cs in
  (row, col)
;;


(** [get_selected (row, col)] sets the [selected] reference to the piece at the specified cell coordinates.
    @param row The row of the chessboard cell.
    @param col The column of the chessboard cell.
*)
let get_selected (row, col) : unit = 
  let pred p = (row, col) = (!(p.row), !(p.col)) && p.color = !turn in
  match List.find_opt pred !gs with
  | None -> ()
  | Some x -> selected := Some x
;;


(** [process_click e] processes a mouse click event, updating the game state accordingly.
    @param e The SDL event representing the mouse click.
*)
let process_click e = 
  let x, y = Sdl.Event.(get e mouse_button_x, get e mouse_button_y) in
  if Sdl.Event.(get e mouse_button_button) <> Sdl.Button.left 
    then ();
  let reset_check() =
    if x > (!offset_x/6) && x < (5*((!offset_x)/6) + 5)
    && y > (!window_h-80) && y < (((!cs/2)+5) + (!window_h-80))
      then begin new_game(); refresh() end
    else ();
  in 
  reset_check();
  let (row, col) = cell_of_pixel x y in
  match !selected with

  | _ when (x < !offset_x) || (y < !offset_y) -> ()

  | Some p -> 
    selected := None;
    let valid = (validate p (row, col) !gs) && not (self_check p (row, col)) in

    if valid then begin
      move p (row, col); 
      last_move := [ (!(p.row), !(p.col)); (row,col)];
      p.first := false; 
      p.row := row; p.col := col;
      end_turn();
      is_in_checkmate !turn !gs;
      refresh()
    end
    else refresh()

  | None -> get_selected (row, col); refresh()
;;
