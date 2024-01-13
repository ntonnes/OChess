
type color = White | Black 
;;

type piece_type = King | Queen | Rook | Bishop | Knight | Pawn 
;;

type piece = {
  piece : piece_type;
  color : color;
  first : bool ref;
  row : int ref;
  col : int ref;
}
;;


(** [file_of_piece p] returns the file path of the texture corresponding to the given chess piece.
    The file path is constructed based on the piece type and color.
    @param p The chess piece.
    @return The file path of the texture for the chess piece.
*)
let file_of_piece p = 

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

  "./assets/"^color^piece^".png";
;;