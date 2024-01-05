open Pieces 

type game_state = piece list

(* initializes a list of pieces that corresponds to a new chess game *)
(* association list *)
let new_game () : piece list = 
  [
  { piece=Rook; color=Black; first=ref true; row=ref 0; col=ref 0; };
  { piece=Knight; color=Black; first=ref true; row=ref 0; col=ref 1; };
  { piece=Bishop; color=Black; first=ref true; row=ref 0; col=ref 2; };
  { piece=Queen; color=Black; first=ref true; row=ref 0; col=ref 3; };
  { piece=King; color=Black; first=ref true; row=ref 0; col=ref 4; };
  { piece=Bishop; color=Black; first=ref true; row=ref 0; col=ref 5; };
  { piece=Knight; color=Black; first=ref true; row=ref 0; col=ref 6; };
  { piece=Rook; color=Black; first=ref true; row=ref 0; col=ref 7; };

  { piece=Pawn; color=Black; first=ref true; row=ref 1; col=ref 0; };
  { piece=Pawn; color=Black; first=ref true; row=ref 1; col=ref 1; };
  { piece=Pawn; color=Black; first=ref true; row=ref 1; col=ref 2; };
  { piece=Pawn; color=Black; first=ref true; row=ref 1; col=ref 3; };
  { piece=Pawn; color=Black; first=ref true; row=ref 1; col=ref 4; };
  { piece=Pawn; color=Black; first=ref true; row=ref 1; col=ref 5; };
  { piece=Pawn; color=Black; first=ref true; row=ref 1; col=ref 6; };
  { piece=Pawn; color=Black; first=ref true; row=ref 1; col=ref 7; };

  { piece=Pawn; color=White; first=ref true; row=ref 6; col=ref 0; };
  { piece=Pawn; color=White; first=ref true; row=ref 6; col=ref 1; };
  { piece=Pawn; color=White; first=ref true; row=ref 6; col=ref 2; };
  { piece=Pawn; color=White; first=ref true; row=ref 6; col=ref 3; };
  { piece=Pawn; color=White; first=ref true; row=ref 6; col=ref 4; };
  { piece=Pawn; color=White; first=ref true; row=ref 6; col=ref 5; };
  { piece=Pawn; color=White; first=ref true; row=ref 6; col=ref 6; };
  { piece=Pawn; color=White; first=ref true; row=ref 6; col=ref 7; };

  { piece=Rook; color=White; first=ref true; row=ref 7; col=ref 0; };
  { piece=Knight; color=White; first=ref true; row=ref 7; col=ref 1; };
  { piece=Bishop; color=White; first=ref true; row=ref 7; col=ref 2; };
  { piece=Queen; color=White; first=ref true; row=ref 7; col=ref 3; };
  { piece=King; color=White; first=ref true; row=ref 7; col=ref 4; };
  { piece=Bishop; color=White; first=ref true; row=ref 7; col=ref 5; };
  { piece=Knight; color=White; first=ref true; row=ref 7; col=ref 6; };
  { piece=Rook; color=White; first=ref true; row=ref 7; col=ref 7; }
  ]