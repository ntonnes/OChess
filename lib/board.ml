open Pieces 
open Constants
open Tsdl

let new_piece row col= Sdl.Rect.create 
  ~x:((col * !cell_size) + 10 + !offset_x) 
  ~y:((row * !cell_size) + 10 + !offset_y) 
  ~w:(!cell_size-20) 
  ~h:(!cell_size-20) 
;;


let new_game () : piece list = 
  [
  { piece=Rook; color=Black; first=true; row=0; col=0 ; rect=new_piece 0 0 };
  { piece=Knight; color=Black; first=true; row=0; col=1; rect=new_piece 0 1 };
  { piece=Bishop; color=Black; first=true; row=0; col=2; rect=new_piece 0 2 };
  { piece=Queen; color=Black; first=true; row=0; col=3; rect=new_piece 0 3 };
  { piece=King; color=Black; first=true; row=0; col=4; rect=new_piece 0 4 };
  { piece=Bishop; color=Black; first=true; row=0; col=5; rect=new_piece 0 5 };
  { piece=Knight; color=Black; first=true; row=0; col=6; rect=new_piece 0 6 };
  { piece=Rook; color=Black; first=true; row=0; col=7; rect=new_piece 0 7 };

  { piece=Pawn; color=Black; first=true; row=1; col=0; rect=new_piece 1 0 };
  { piece=Pawn; color=Black; first=true; row=1; col=1; rect=new_piece 1 1 };
  { piece=Pawn; color=Black; first=true; row=1; col=2; rect=new_piece 1 2 };
  { piece=Pawn; color=Black; first=true; row=1; col=3; rect=new_piece 1 3 };
  { piece=Pawn; color=Black; first=true; row=1; col=4; rect=new_piece 1 4 };
  { piece=Pawn; color=Black; first=true; row=1; col=5; rect=new_piece 1 5 };
  { piece=Pawn; color=Black; first=true; row=1; col=6; rect=new_piece 1 6 };
  { piece=Pawn; color=Black; first=true; row=1; col=7; rect=new_piece 1 7 };

  { piece=Pawn; color=White; first=true; row=6; col=0; rect=new_piece 6 0 };
  { piece=Pawn; color=White; first=true; row=6; col=1; rect=new_piece 6 1 };
  { piece=Pawn; color=White; first=true; row=6; col=2; rect=new_piece 6 2 };
  { piece=Pawn; color=White; first=true; row=6; col=3; rect=new_piece 6 3 };
  { piece=Pawn; color=White; first=true; row=6; col=4; rect=new_piece 6 4 };
  { piece=Pawn; color=White; first=true; row=6; col=5; rect=new_piece 6 5 };
  { piece=Pawn; color=White; first=true; row=6; col=6; rect=new_piece 6 6 };
  { piece=Pawn; color=White; first=true; row=6; col=7; rect=new_piece 6 7 };

  { piece=Rook; color=White; first=true; row=7; col=0; rect=new_piece 7 0 };
  { piece=Knight; color=White; first=true; row=7; col=1; rect=new_piece 7 1 };
  { piece=Bishop; color=White; first=true; row=7; col=2; rect=new_piece 7 2 };
  { piece=Queen; color=White; first=true; row=7; col=3; rect=new_piece 7 3 };
  { piece=King; color=White; first=true; row=7; col=4; rect=new_piece 7 4 };
  { piece=Bishop; color=White; first=true; row=7; col=5; rect=new_piece 7 5 };
  { piece=Knight; color=White; first=true; row=7; col=6; rect=new_piece 7 6 };
  { piece=Rook; color=White; first=true; row=7; col=7; rect=new_piece 7 7 }
  ]