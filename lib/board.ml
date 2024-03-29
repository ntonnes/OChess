open Pieces 


(** [make piece color row col] creates a new piece with the specified attributes.
    @param piece The type of chess piece.
    @param color The color of the piece (Black or White).
    @param row The initial row position of the piece.
    @param col The initial column position of the piece.
    @return A new piece with the given attributes.
*)
let make piece color row col = 
  { piece=piece; color=color; first=ref true; row=ref row; col=ref col; }
;;


(** [copy_piece piece] creates a copy of the given chess piece.
    @param piece The chess piece to be copied.
    @return A new chess piece with the same attributes as the original.
*)
let copy_piece (piece : piece) : piece =
  {
    piece = piece.piece;
    color = piece.color;
    first = ref !(piece.first);
    row = ref !(piece.row);
    col = ref !(piece.col);
  }
;;


(** [copy_board board] creates a copy of the given chess board.
    @param board The list of chess pieces representing the board.
    @return A new list of chess pieces with the same attributes as the original board.
*)
let copy_board (board : piece list) : piece list =
  List.map copy_piece board
;;


(** [new_board ()] creates a new chess board with the initial piece positions.
    @return A list of pieces representing the initial state of the chess board.
*)
let new_board () : piece list = 
  [
    make Rook   Black 0 0;
    make Knight Black 0 1;
    make Bishop Black 0 2;
    make Queen  Black 0 3;
    make King   Black 0 4;
    make Bishop Black 0 5;
    make Knight Black 0 6;
    make Rook   Black 0 7;
    
    make Pawn Black 1 0;
    make Pawn Black 1 1;
    make Pawn Black 1 2;
    make Pawn Black 1 3;
    make Pawn Black 1 4;
    make Pawn Black 1 5;
    make Pawn Black 1 6;
    make Pawn Black 1 7;
    
    make Pawn White 6 0;
    make Pawn White 6 1;
    make Pawn White 6 2;
    make Pawn White 6 3;
    make Pawn White 6 4;
    make Pawn White 6 5;
    make Pawn White 6 6;
    make Pawn White 6 7;
    
    make Rook   White 7 0;
    make Knight White 7 1;
    make Bishop White 7 2;
    make Queen  White 7 3;
    make King   White 7 4;
    make Bishop White 7 5;
    make Knight White 7 6;
    make Rook   White 7 7;
  ]
;;