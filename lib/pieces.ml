(* defines chess pieces *)
type color = White | Black 
type first = bool
type piece =
| King of color * first
| Queen of color
| Rook of color * first
| Bishop of color
| Knight of color
| Pawn of color * first


(* converts a chess piece to a string describing it *)
let pieceString piece = 
  match piece with
  | King (Black, _) -> "Black King"
  | King (White, _) -> "White King"
  | Queen Black -> "Black Queen"
  | Queen White -> "White Queen"
  | Rook (Black, _) -> "Black Rook"
  | Rook (White, _) -> "White Rook"
  | Bishop Black -> "Black Bishop"
  | Bishop White -> "White Bishop"
  | Knight Black -> "Black Knight"
  | Knight White -> "White Knight"
  | Pawn (Black, _) -> "Black Pawn"
  | Pawn (White, _) -> "White Pawn"
;;