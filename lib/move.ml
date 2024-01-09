open Pieces
open Globals


(* 
   Function: valid_pawn_forward
   Checks if the destination is valid for a pawn forward capture move.
   Parameters:
     - piece: The pawn piece
     - dest: Destination (row, col) coordinates
   Returns: bool
*)
let valid_pawn_capture piece dest = 
  let pred p = dest = (!(p.row), !(p.col)) in
  match List.find_opt pred !gs with
  | Some x when x.color <> piece.color -> true
  | _ -> false
;;


(* 
   Function: valid_pawn_forward
   Checks if the destination is valid for a pawn forward move.
   Parameters:
     - dest: Destination (row, col) coordinates
   Returns: bool
*)
let valid_pawn_forward dest = 
  let pred p = dest = (!(p.row), !(p.col)) in
  match List.find_opt pred !gs with
  | None -> true
  | _ -> false
;;


(* 
   Function: move_xxx
   Checks if the given vector (dx, dy) represents a valid movement for piece xxx.
   Parameters:
     - dx: Change in x-coordinate
     - dy: Change in y-coordinate
   Returns: bool
*)
let move_king dx dy =
  if abs dx < 2 && abs dy < 2 then true
  else false
;;

let move_queen dx dy = 
  if (dx = 0 && dy <> 0) || (dy = 0 && dx <> 0) then true
  else if abs dx = abs dy then true
  else false
;;

let move_rook dx dy = 
  if (dx = 0 && dy <> 0) || (dy = 0 && dx <> 0) then true
  else false
;;

let move_bishop dx dy = 
  if abs dx = abs dy then true 
  else false
;;

let move_knight dx dy = 
  if (abs dx = 1 && abs dy = 2) || (abs dy = 1 && abs dx = 2) then true
  else false
;;

let move_pawn piece dx dy dest = 
  if piece.color = White then 
    if !(piece.first) && dx = 2 && dy = 0 && !(piece.first) then true
    else if dx = 1 && dy = 0 then valid_pawn_forward dest
    else if dx = 1 && abs dy = 1 then valid_pawn_capture piece dest
    else false
  else
    if !(piece.first) && dx = -2 && dy = 0 && !(piece.first) then true
    else if dx = -1 && dy = 0 then valid_pawn_forward dest
    else if dx = -1 && abs dy = 1 then valid_pawn_capture piece dest
    else false
  ;;
;;

