open Globals
open Pieces
open Draw
open Validate


(* 
   Function: cell_of_pixel
   Takes screen coordinates (x, y) and calculates the corresponding chess board cell (row, col).
   Returns: (row, col) tuple
*)
let cell_of_pixel x y : (int * int) = 
  let col = (x - !offset_x) / !cell_size in
  let row = (y - !offset_y) / !cell_size in
  (row, col)
;;


(* 
   Function: get_selected
   Takes chess board coordinates (row, col) and updates the selected piece variable.
   Returns: none
*)
let get_selected (row, col) : unit = 
  let pred p = (row, col) = (!(p.row), !(p.col)) in
  match List.find_opt pred !gs with
  | None -> ()
  | Some x -> selected := Some x
;;


(* 
   Function: process
   Handles the processing of mouse clicks on the chess board.
   Updates the selected piece and refreshes the game window accordingly.
   Returns: none
*)
let process x y = 
  let (row, col) = cell_of_pixel x y in
  match !selected with

  | Some p -> selected := None;
    begin match validate p (row, col) with
    | false -> ()
    | true -> p.row := row; p.col := col;
    end;
    refresh ();

  | None -> get_selected (row, col); refresh()
;;
