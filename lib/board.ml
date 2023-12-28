open Pieces 

(* update the piece list based on the current window size
let adjust_pieces piece_list : piece list= 
  let fix p = 
    { piece=p.piece; color=p.color; first=p.first; row=p.row; col=p.col; }
  in 
  let updated_pieces = List.map (fun p -> fix p) piece_list in
  updated_pieces *)


(* initializes a list of pieces that corresponds to a new chess game *)
let new_game () : piece list = 
  [
  { piece=Rook; color=Black; first=true; row=0; col=0; };
  { piece=Knight; color=Black; first=true; row=0; col=1; };
  { piece=Bishop; color=Black; first=true; row=0; col=2; };
  { piece=Queen; color=Black; first=true; row=0; col=3; };
  { piece=King; color=Black; first=true; row=0; col=4; };
  { piece=Bishop; color=Black; first=true; row=0; col=5; };
  { piece=Knight; color=Black; first=true; row=0; col=6; };
  { piece=Rook; color=Black; first=true; row=0; col=7; };

  { piece=Pawn; color=Black; first=true; row=1; col=0; };
  { piece=Pawn; color=Black; first=true; row=1; col=1; };
  { piece=Pawn; color=Black; first=true; row=1; col=2; };
  { piece=Pawn; color=Black; first=true; row=1; col=3; };
  { piece=Pawn; color=Black; first=true; row=1; col=4; };
  { piece=Pawn; color=Black; first=true; row=1; col=5; };
  { piece=Pawn; color=Black; first=true; row=1; col=6; };
  { piece=Pawn; color=Black; first=true; row=1; col=7; };

  { piece=Pawn; color=White; first=true; row=6; col=0; };
  { piece=Pawn; color=White; first=true; row=6; col=1; };
  { piece=Pawn; color=White; first=true; row=6; col=2; };
  { piece=Pawn; color=White; first=true; row=6; col=3; };
  { piece=Pawn; color=White; first=true; row=6; col=4; };
  { piece=Pawn; color=White; first=true; row=6; col=5; };
  { piece=Pawn; color=White; first=true; row=6; col=6; };
  { piece=Pawn; color=White; first=true; row=6; col=7; };

  { piece=Rook; color=White; first=true; row=7; col=0; };
  { piece=Knight; color=White; first=true; row=7; col=1; };
  { piece=Bishop; color=White; first=true; row=7; col=2; };
  { piece=Queen; color=White; first=true; row=7; col=3; };
  { piece=King; color=White; first=true; row=7; col=4; };
  { piece=Bishop; color=White; first=true; row=7; col=5; };
  { piece=Knight; color=White; first=true; row=7; col=6; };
  { piece=Rook; color=White; first=true; row=7; col=7; }
  ]