open Pieces
open Globals
open Pawn


(* 
   Function: illegal_jump
   Checks if there is an obstacle in the path of the piece's move.
   Parameters:
     - piece: The chess piece
     - dest: Destination coordinates
   Returns: bool
*)
let illegal_jump piece dest = 
  let rec has_obstacle row col acc =
    if row = !(piece.row) && col = !(piece.col) then false
    else if List.exists (fun p -> !(p.row) = row && !(p.col) = col && acc <> 0) !gs then true
    else
      let new_row, new_col =
        if row = !(piece.row) then row, (col + (if !(piece.col) < snd dest then -1 else 1))
        else if col = !(piece.col) then (row + (if !(piece.row) < fst dest then -1 else 1)), col
        else (row + (if !(piece.row) < fst dest then -1 else 1)), (col + (if !(piece.col) < snd dest then -1 else 1))
      in
      has_obstacle new_row new_col (acc+1)
  in
  match piece.piece with
  | King | Knight -> false (* No need to check for obstacles for King and Knight *)
  | _ -> has_obstacle (fst dest) (snd dest) 0
;;


(* 
   Function: try_dest
   Attempts to make a move to the destination and handles the outcome.
   Parameters:
     - piece: The chess piece
     - dest: Destination coordinates
   Returns: bool
*)
let try_dest piece dest = 
  let pred p = dest = (!(p.row), !(p.col)) in
  match List.find_opt pred !gs with
  | None -> piece.first := false; true
  | Some x when x.color = piece.color -> false
  | Some x -> 
    let pred p = x <> p in
    gs := List.filter pred (!gs);
    piece.first := false;
    if x.piece = King then victor := Some piece.color;
    match !turn with
    | Black -> 
      captures_black := List.append [x] !captures_black; true
    | White -> 
      captures_white := List.append [x] !captures_white; true
;;

let correct_turn piece = 
  piece.color = !turn

(* 
   Function: validate
   Validates the move of a chess piece to the destination coordinates.
   Parameters:
     - piece: The chess piece
     - dest: Destination coordinates
   Returns: bool
*)
let validate piece dest = 
  let dx, dy = !(piece.row)-(fst dest), !(piece.col)-(snd dest) in
  let try_move = match piece.piece with
    | King -> (abs dx<2) && (abs dy<2) 
    | Queen -> (dx=0 && dy<>0) || (dy=0 && dx<>0) || (abs dx=abs dy)
    | Bishop -> (abs dx=abs dy)
    | Knight -> (abs dx=1 && abs dy=2) || (abs dy=1 && abs dx=2)
    | Rook -> (dx = 0 && dy <> 0) || (dy = 0 && dx <> 0)
    | Pawn -> move_pawn piece dx dy dest
  in
  if not (illegal_jump piece dest) && try_move && correct_turn piece then 
    try_dest piece dest
  else false
;;
