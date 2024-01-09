open Pieces
open Constants
open Path

let validate_king dx dy =
  if abs dx < 2 && abs dy < 2 then true
  else false
;;

let validate_queen dx dy = 
  if (dx = 0 && dy <> 0) || (dy = 0 && dx <> 0) then true
  else if abs dx = abs dy then true
  else false
;;

let validate_rook dx dy = 
  if (dx = 0 && dy <> 0) || (dy = 0 && dx <> 0) then true
  else false
;;

let validate_bishop dx dy = 
  if abs dx = abs dy then true 
  else false
;;

let validate_knight dx dy = 
  if (abs dx = 1 && abs dy = 2) || (abs dy = 1 && abs dx = 2) then true
  else false
;;

let valid_pawn_capture piece dest = 
  let pred p = dest = (!(p.row), !(p.col)) in
  match List.find_opt pred !gs with
  | Some x when x.color <> piece.color -> true
  | _ -> false
;;

let validate_pawn piece dx dy dest = 
  if piece.color = White then 
    if !(piece.first) && dx = 2 && dy = 0 && !(piece.first) then true
    else if dx = 1 && dy = 0 then true
    else if dx = 1 && abs dy = 1 then valid_pawn_capture piece dest
    else false
  else
    if !(piece.first) && dx = -2 && dy = 0 && !(piece.first) then true
    else if dx = -1 && dy = 0 then true  
    else if dx = -1 && abs dy = 1 then valid_pawn_capture piece dest
    else false
  ;;
;;

let valid_destination piece dest = 
  let pred p = dest = (!(p.row), !(p.col)) in
  match List.find_opt pred !gs with
  | None -> true
  | Some x when x.color = piece.color -> false
  | Some x -> 
    let predd p = x <> p in
    gs := List.filter predd (!gs);
    true
;;

let validate piece dest = 
  let dx, dy = !(piece.row)-(fst dest), !(piece.col)-(snd dest) in
  let valid_movement = match piece.piece with
    | King -> validate_king dx dy
    | Queen -> validate_queen dx dy
    | Bishop -> validate_bishop dx dy
    | Knight -> validate_knight dx dy
    | Rook -> validate_rook dx dy
    | Pawn -> validate_pawn piece dx dy dest
  in
  if not (illegal_jump piece dest) && valid_movement && valid_destination piece dest then 
    begin piece.first := false; true end
  else false
