open Constants
open Pieces
open Draw
open Validate

let selected_cell x y = 
  let col = (x - !offset_x) / !cell_size in
  let row = (y - !offset_y) / !cell_size in
  Printf.printf "Left mouse button clicked at row %d, column %d\n" row col;
  (row, col)
;;

let get_selected piece_list coord = 
  let pred p = if coord = (!(p.row), !(p.col)) then true else false in
  match List.find_opt pred piece_list with
  | None -> ()
  | Some x -> selected := Some x
  
;;

let process window piece_list x y renderer= 
  let coord = selected_cell x y in
  let go () = match !selected with
  | Some p -> 
    if validate p coord then begin
      p.row := fst coord;
      p.col := snd coord;
    end;
    selected := None
  | None -> get_selected piece_list coord
  in
  go ();
  refresh_window window renderer piece_list
;;
