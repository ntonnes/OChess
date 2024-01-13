open Tsdl
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
  let col = (x - !offset_x) / !cs in
  let row = (y - !offset_y) / !cs in
  (row, col)
;;


(* 
   Function: get_selected
   Takes chess board coordinates (row, col) and updates the selected piece variable.
   Returns: none
*)
let get_selected (row, col) : unit = 
  let pred p = (row, col) = (!(p.row), !(p.col)) && p.color = !turn in
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
let process_click e = 
  let x, y = Sdl.Event.(get e mouse_button_x, get e mouse_button_y) in
  if Sdl.Event.(get e mouse_button_button) <> Sdl.Button.left 
    then ();
  let (row, col) = cell_of_pixel x y in
  match !selected with

  | Some p -> selected := None;
    begin match validate p (row, col) with
    | false -> ()
    | true -> p.row := row; p.col := col; end_turn ();
    end;
    refresh();

  | None -> get_selected (row, col); refresh()
;;
