open Tsdl

type color = White | Black ;;
type piece_type = King | Queen | Rook | Bishop | Knight | Pawn ;;

type piece = {
  piece : piece_type;
  color : color;
  first : bool;
  row : int;
  col : int;
  rect : Sdl.rect
}
;;


(* converts a chess piece to a string describing it *)
let string_of_piece p = 

  let piece = match p.piece with
    | King -> "King"
    | Queen -> "Queen"
    | Rook -> "Rook"
    | Bishop -> "Bishop"
    | Knight-> "Knight"
    | Pawn -> "Pawn"
  in

  let color = match p.color with
    | Black -> "Black "
    | White -> "White "
  in

  piece^color;
;;