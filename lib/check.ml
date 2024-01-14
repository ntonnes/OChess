open Pieces
open Validate

let possible_moves king gs =
  let (r, c) = (!(king.row), !(king.col)) in
  let adj_list = [
    (r+1, c); (r-1, c);
    (r, c+1); (r, c-1); (r+1, c+1); 
    (r-1, c-1); (r+1, c-1); (r-1, c+1);
  ] 
  in
  let in_range = List.filter (fun (r, c) -> r>=0 && r<8 && c>=0 && c<8) adj_list in
  let valid_moves = List.filter (fun dst -> validate king gs dst) in_range in
  valid_moves
;;


let is_square_attacked gs dst color =
  let opponent_color = if color = White then Black else White in
  let attacking_pieces = List.filter (fun piece -> piece.color = opponent_color) gs in
  List.exists (fun piece -> validate piece gs dst) attacking_pieces
;;


let all_moves_attacked gs color =
  let king_opt = List.find_opt (fun piece -> piece.piece=King && piece.color=color) gs in
  match king_opt with
  | Some king ->
    let moves = possible_moves king gs in
    not (List.is_empty moves) && (List.for_all (fun dst -> is_square_attacked gs dst color) moves)
  | None -> false
;;

let king_attacked gs color =
  let king_opt = List.find_opt (fun piece -> piece.piece=King && piece.color=color) gs in
  match king_opt with
  | Some king ->
    let dst = (!(king.row), !(king.col)) in
    List.exists (fun p -> validate p gs dst) gs
  | None -> false
;;
