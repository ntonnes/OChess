open Pieces
open Globals
open Pawn


let get_piece tile gs = 
  List.find_opt (fun p -> !(p.row)=(fst tile) && !(p.col)=(snd tile)) gs
;;


(** [illegal_jump piece dest] checks if there are obstacles on the path of a move for non-knight and non-king pieces.
    It recursively checks for obstacles in the row, column, or diagonal direction based on the destination coordinates.
    @param piece The chess piece to be moved.
    @param dest The destination coordinates (row, col) on the chessboard.
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


(** [try_dest piece dest] attempts to move a piece to the destination, capturing opponent pieces if necessary.
    It updates the game state, captures, and checks for a victory condition.
    @param piece The chess piece to be moved.
    @param dest The destination coordinates (row, col) on the chessboard.
    @return [true] if the move is successful, [false] otherwise.
*)
let valid_dst piece dest gs = 
  match get_piece dest gs with
  | None -> true
  | Some x when x.color = piece.color -> false
  | Some _ -> true
;;

let valid_vector piece dest =
  let dx, dy = !(piece.row)-(fst dest), !(piece.col)-(snd dest) in
  match piece.piece with
  | King -> (abs dx<2) && (abs dy<2) 
  | Queen -> (dx=0 && dy<>0) || (dy=0 && dx<>0) || (abs dx=abs dy)
  | Bishop -> (abs dx=abs dy)
  | Knight -> (abs dx=1 && abs dy=2) || (abs dy=1 && abs dx=2)
  | Rook -> (dx = 0 && dy <> 0) || (dy = 0 && dx <> 0)
  | Pawn -> move_pawn piece dx dy dest
;;


(** [validate piece dest] checks if a move is valid for a given chess piece to the specified destination.
    It considers the piece type and calls the appropriate validation function.
    @param piece The chess piece to be moved.
    @param dest The destination coordinates (row, col) on the chessboard.
    @return [true] if the move is valid, [false] otherwise.
*)

let validate piece dest gs = 
  not (illegal_jump piece dest gs) 
  && (valid_vector piece dest) 
  && (valid_dst piece dest gs)
;;

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

let good_move piece dest = 
  let dx, dy = !(piece.row)-(fst dest), !(piece.col)-(snd dest) in
  let try_move = match piece.piece with
    | King -> (abs dx<2) && (abs dy<2) 
    | Queen -> (dx=0 && dy<>0) || (dy=0 && dx<>0) || (abs dx=abs dy)
    | Bishop -> (abs dx=abs dy)
    | Knight -> (abs dx=1 && abs dy=2) || (abs dy=1 && abs dx=2)
    | Rook -> (dx = 0 && dy <> 0) || (dy = 0 && dx <> 0)
    | Pawn -> move_pawn piece dx dy dest
  in
  if not (illegal_jump piece dest !gs) && try_move then 
    let pred p = dest = (!(p.row), !(p.col)) in
    match List.find_opt pred !gs with
    | None -> true
    | Some x when x.color = piece.color -> false
    | _ -> true
  else false
;;