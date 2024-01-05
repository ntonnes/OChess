open Pieces

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

let validate_pawn piece dx dy = 
  if piece.color = White then 
    if !(piece.first) && dx = 2 && dy = 0 then true
    else if dx = 1 && dy = 0 then true
    else false
  else 
    if !(piece.first) && dx = -2 && dy = 0 then true
    else if dx = -1 && dy = 0 then true  
    else false

let validate piece dest = 
  let s_row, s_col = !(piece.row), !(piece.col) in
  let d_row, d_col = (fst dest), (snd dest) in
  let dx, dy = (s_row - d_row), (s_col - d_col) in
  match piece.piece with
  | King -> validate_king dx dy
  | Queen -> validate_queen dx dy
  | Bishop -> validate_bishop dx dy
  | Knight -> validate_knight dx dy
  | Rook -> validate_rook dx dy
  | Pawn -> validate_pawn piece dx dy