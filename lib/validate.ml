open Pieces
open Globals
open Move
open Win


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
  | None -> true
  | Some x when x.color = piece.color -> false
  | Some x -> 
    if x.piece = King then win x.color;
    let pred p = x <> p in
    gs := List.filter pred (!gs);
    true
;;


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
    | King -> move_king dx dy
    | Queen -> move_queen dx dy
    | Bishop -> move_bishop dx dy
    | Knight -> move_knight dx dy
    | Rook -> move_rook dx dy
    | Pawn -> move_pawn piece dx dy dest
  in
  if not (illegal_jump piece dest)  && try_move && (try_dest piece dest) then 
    begin piece.first := false; true end
  else false
