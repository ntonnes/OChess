open Constants
open Pieces
open Draw
open Tsdl

let selected_cell x y = 
  let col = (x - !offset_x) / !cell_size in
  let row = (y - !offset_y) / !cell_size in
  Printf.printf "Left mouse button clicked at row %d, column %d\n" row col;
  (row, col)
;;

let get_piece piece_list coord = 
  let pred p = if coord = (!(p.row), !(p.col)) then true else false in
  List.find_opt pred  piece_list
;;

let process piece_list x y renderer= 
  let coord = selected_cell x y in
  match !selected with
  | Some p -> 
    if coord = (!(p.row), !(p.col)) then begin 
      selected := None; () 
    end
    else begin
      p.row := fst coord;
      p.col := snd coord;
      selected := None;
      render_chessboard renderer;
      render_pieces renderer piece_list;
      Sdl.render_present renderer;
    end
  | None ->
    begin match get_piece piece_list coord with
    | None -> Printf.printf "No piece selected";
    | Some x -> 
      selected := Some x;
      Printf.printf "Piece selected: %s\n" (Pieces.string_of_piece x);
    end
  ;;
;;
