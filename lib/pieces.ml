(* 
   Type: color
   Represents the color of a chess piece.
*)
type color = White | Black 
;;


(* 
   Type: piece_type
   Represents the type of a chess piece.
*)
type piece_type = King | Queen | Rook | Bishop | Knight | Pawn 
;;


(* 
   Type: piece
   Represents a chess piece with its attributes.
*)
type piece = {
  piece : piece_type;
  color : color;
  first : bool ref;
  row : int ref;
  col : int ref;
}
;;


(* 
   Function: file_of_piece
   Converts a chess piece to the name of its texture file.
   Parameters:
     - p: The chess piece
   Returns: string
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