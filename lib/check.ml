open Pieces
open Validate
open Globals

exception Bad_sim

let is_in_check color gs =
  let king_opt = List.find_opt (fun piece -> piece.piece=King && piece.color=color) gs in
  match king_opt with
  | Some king ->
    let dst = (!(king.row), !(king.col)) in
    print_int (fst dst);
    print_int (snd dst);
    print_newline();
    List.exists (fun p -> validate p dst gs) gs
  | None -> raise Bad_sim
;;


let get_valid_moves piece =
  let all_dst = List.init 8 (fun row ->
      List.init 8 (fun col -> (row, col))
    ) |> List.flatten
  in 
  List.filter (fun dst -> validate piece dst !gs) all_dst
;;


let self_check piece dst = 
  let sim_board =
    List.filter (fun p -> 
      not (!(p.row)=fst dst && !(p.col)=snd dst) 
      && not (!(piece.row)= !(p.row) && !(piece.col)= !(p.col))
      ) !gs
  in
  let new_sim_board = sim_board@[
    { piece=piece.piece; color=piece.color; first=ref false; row=ref (fst dst); col=ref (snd dst); }
  ]
  in
  is_in_check piece.color new_sim_board
;;


(*let is_in_checkmate color gs = 
  let enemies = List.filter (fun p -> p.color<>color) gs in
  let 
*)
(*
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


let all_moves_attacked gs color =
  let king_opt = List.find_opt (fun piece -> piece.piece=King && piece.color=color) gs in
  match king_opt with
  | Some king ->
    let moves = possible_moves king gs in
    not (List.is_empty moves) && (List.for_all (fun dst -> is_square_attacked gs dst color) moves)
  | None -> false
;;

let is_in_check color =
  let king_opt = List.find_opt (fun piece -> piece.piece=King && piece.color=color) gs in
  match king_opt with
  | Some king ->
    let dst = (!(king.row), !(king.col)) in
    List.exists (fun p -> validate p gs dst) gs
  | None -> false
;;
*)