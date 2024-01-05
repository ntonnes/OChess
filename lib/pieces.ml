type color = White | Black ;;
type piece_type = King | Queen | Rook | Bishop | Knight | Pawn ;;



(* struct for pieces*)
type piece = {
  piece : piece_type;
  color : color;
  first : bool ref;
  row : int ref;
  col : int ref;
}
;;



(* converts a chess piece to a string describing it *)
let string_of_piece p = 

  let piece = match p.piece with
    | King -> "king"
    | Queen -> "queen"
    | Rook -> "rook"
    | Bishop -> "bishop"
    | Knight-> "knight"
    | Pawn -> "pawn"
  in

  let color = match p.color with
    | Black -> "black_"
    | White -> "white_"
  in

  color^piece;
;;