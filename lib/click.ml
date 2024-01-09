open Constants
open Pieces
open Draw
open Validate

let selected_cell x y = 
  let col = (x - !offset_x) / !cell_size in
  let row = (y - !offset_y) / !cell_size in
  (row, col)
;;

let get_selected coord = 
  let pred p = if coord = (!(p.row), !(p.col)) then true else false in
  match List.find_opt pred !gs with
  | None -> ()
  | Some x -> selected := Some x
  
;;

let process window x y renderer = 
  let coord = selected_cell x y in
  match !selected with
  | Some p -> 
    begin match validate p coord with
    | false -> 
      selected := None;
      refresh_window window renderer 

    | true -> 
      selected := None;
      p.row := fst coord;
      p.col := snd coord;
      refresh_window window renderer 


    end;
    
  | None -> 
    get_selected coord;
    refresh_window window renderer
;;
