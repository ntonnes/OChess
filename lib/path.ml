open Constants
open Pieces

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

