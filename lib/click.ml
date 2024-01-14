open Tsdl
open Globals
open Pieces
open Draw
open Validate


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
  let (row, col) = cell_of_pixel x y in
  match !selected with

  | Some p -> selected := None;
    begin match validate p (row, col) !gs with
    | false -> ()
    | true -> move p (row, col) !gs; p.row := row; p.col := col; end_turn ();
    end;
    refresh();

  | None -> get_selected (row, col); refresh()
;;
