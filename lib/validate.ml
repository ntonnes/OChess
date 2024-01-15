open Pieces
open Globals
open Pawn


(** [get_piece tile gs] finds the chess piece at the specified tile on the game board.
    @param tile The coordinates (row, column) of the tile.
    @param gs The list of chess pieces representing the current game state.
    @return The chess piece at the specified tile, or None if no piece is present.
*)
let get_piece tile gs = 
  List.find_opt (fun p -> !(p.row)=(fst tile) && !(p.col)=(snd tile)) gs
;;


(** [illegal_jump piece dest] checks if there are obstacles on the path of a move for non-knight and non-king pieces.
    It recursively checks for obstacles in the row, column, or diagonal direction based on the destination coordinates.
    @param piece The chess piece to be moved.
    @param dest The destination coordinates (row, col) on the chessboard.
    @param gs The list of chess pieces representing the current game state.
    @return [true] if there is an obstacle on the path, [false] otherwise.
*)
let illegal_jump piece dest gs = 
  let rec has_obstacle row col acc =
    if row = !(piece.row) && col = !(piece.col) then false
    else if List.exists (fun p -> !(p.row) = row && !(p.col) = col && acc <> 0) gs then true
    else
      let new_row, new_col =
        if row = !(piece.row) then row, (col + (if !(piece.col) < snd dest then -1 else 1))
        else if col = !(piece.col) then (row + (if !(piece.row) < fst dest then -1 else 1)), col
        else (row + (if !(piece.row) < fst dest then -1 else 1)), (col + (if !(piece.col) < snd dest then -1 else 1))
      in
      has_obstacle new_row new_col (acc+1)
  in
  match piece.piece with
  | King | Knight -> false 
  | _ -> has_obstacle (fst dest) (snd dest) 0
;;


(** [valid_dst piece dest gs] checks if the destination is a valid move for the given chess piece.
    @param piece The chess piece to be moved.
    @param dest The destination coordinates (row, column) of the move.
    @param gs The list of chess pieces representing the current game state.
    @return `true` if the destination is valid, `false` otherwise.
*)
let valid_dst piece dest gs = 
  match get_piece dest gs with
  | None -> true
  | Some x when x.color = piece.color -> false
  | Some _ -> true
;;


(** [valid_vector piece dest gs] checks if moving the given chess piece to the destination is a valid move based on its type.
    @param piece The chess piece to be moved.
    @param dest The destination coordinates (row, column) of the move.
    @param gs The list of chess pieces representing the current game state.
    @return `true` if the move is valid, `false` otherwise.
*)
let valid_vector piece dest gs =
  let dx, dy = !(piece.row)-(fst dest), !(piece.col)-(snd dest) in
  match piece.piece with
  | King -> (abs dx<2) && (abs dy<2) 
  | Queen -> (dx=0 && dy<>0) || (dy=0 && dx<>0) || (abs dx=abs dy)
  | Bishop -> (abs dx=abs dy)
  | Knight -> (abs dx=1 && abs dy=2) || (abs dy=1 && abs dx=2)
  | Rook -> (dx = 0 && dy <> 0) || (dy = 0 && dx <> 0)
  | Pawn -> move_pawn piece dx dy dest gs
;;


(** [validate piece dest] checks if a move is valid for a given chess piece to the specified destination.
    It considers the piece type and calls the appropriate validation function.
    @param piece The chess piece to be moved.
    @param dest The destination coordinates (row, col) on the chessboard.
    @param gs The list of chess pieces representing the current game state.
    @return [true] if the move is valid, [false] otherwise.
*)

let validate piece dest gs = 
  not (illegal_jump piece dest gs) 
  && (valid_vector piece dest gs) 
  && (valid_dst piece dest gs)
;;


(** [move piece dest] handles the movement of a chess piece to the specified destination.
    @param piece The chess piece to be moved.
    @param dest The destination coordinates (row, column) of the move.
*)
let move piece dest = 
  match get_piece dest !gs with
  | Some x when x.color<>piece.color ->
    if x.piece = King then victor := Some piece.color;
    let pred p = x <> p in
    gs := List.filter pred (!gs);
    begin match !turn with
    | Black -> 
      captures_black := List.append [x] !captures_black;
    | White -> 
      captures_white := List.append [x] !captures_white;
    end
  | _ -> () 
;;
