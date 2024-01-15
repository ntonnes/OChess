open Pieces
open Validate
open Globals
open Board


(** [is_in_check color gs] checks if the player of the specified color is in check.
    @param color The color of the player (Black or White).
    @param gs The list of chess pieces representing the current game state.
    @return `true` if the player is in check, `false` otherwise.
*)
let is_in_check color gs =
  let king_opt = List.find_opt (fun piece -> piece.piece=King && piece.color=color) gs in
  match king_opt with
  | Some king ->
    let dst = (!(king.row), !(king.col)) in
    List.exists (fun p -> validate p dst gs) gs
  | None -> false
;;


(** [possible_moves king gs] computes the possible moves for the given king on the chess board.
    @param king The chess piece representing the king.
    @param gs The list of chess pieces representing the current game state.
    @return The list of valid moves for the king.
*)
let possible_moves king gs =
  let (r, c) = (!(king.row), !(king.col)) in
  let adj_list = [
    (r+1, c); (r-1, c);
    (r, c+1); (r, c-1); (r+1, c+1); 
    (r-1, c-1); (r+1, c-1); (r-1, c+1);
  ] 
  in
  let in_range = List.filter (fun (r, c) -> r>=0 && r<8 && c>=0 && c<8) adj_list in
  let valid_moves = List.filter (fun dst -> validate king dst gs) in_range in
  valid_moves
;;


(** [self_check piece dst] checks if the player puts themselves in check by making a move.
    @param piece The chess piece making the move.
    @param dst The destination coordinates of the move.
    @return `true` if the move puts the player in check, `false` otherwise.
*)
let self_check piece dst = 
  let sim_board = ref (copy_board !gs) in

  sim_board := List.filter (fun p -> 
  not (!(p.row)=fst dst && !(p.col)=snd dst) 
  && not (!(piece.row)= !(p.row) && !(piece.col)= !(p.col))
  ) !sim_board;

  sim_board := (!sim_board)@[
    { piece=piece.piece; color=piece.color; first=ref false; row=ref (fst dst); col=ref (snd dst); }
  ];

  is_in_check piece.color !sim_board
;;


(** [is_in_checkmate color gs] checks if the player of the specified color is in checkmate.
    @param color The color of the player (Black or White).
    @param gs The list of chess pieces representing the current game state.
*)
let is_in_checkmate color gs = 
  if List.exists (fun p -> 
    let moves = possible_moves p gs in
    List.exists (fun dst -> not (self_check p dst)) moves 
  ) (List.filter (fun p -> p.color=color) gs)
    then ()
  else victor := Some (opp color);
;;
