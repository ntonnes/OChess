open Pieces 

(*
   Function: make
   Creates a new piece with the specified attributes.
   Parameters:
     - piece: The type of chess piece (e.g., Rook, Knight, etc.)
     - color: The color of the piece (Black or White)
     - row: The initial row position of the piece on the chess board
     - col: The initial column position of the piece on the chess board
   Returns: piece
*)
let make piece color row col = 
  { piece=piece; color=color; first=ref true; row=ref row; col=ref col; }
;;


(*
   Function: new_game
   Initializes a list of pieces that corresponds to a new chess game.
   Returns: piece list
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