open Pieces 
open Constants
open Tsdl
open Img

(**)
let new_piece row col = Sdl.Rect.create 
  ~x:((col * !cell_size) + (!cell_size/10) + !offset_x) 
  ~y:((row * !cell_size) + (!cell_size/10) + !offset_y) 
  ~w:(!cell_size - (!cell_size/5)) 
  ~h:(!cell_size - (!cell_size/5)) 
;;

(* update the piece list based on the current window size*)
let adjust_pieces piece_list : piece list= 
  let fix p = 
    { piece=p.piece; color=p.color; first=p.first; row=p.row; col=p.col; rect=new_piece p.row p.col; img=p.img }
  in 
  let updated_pieces = List.map (fun p -> fix p) piece_list in
  updated_pieces


(* initializes a list of pieces that corresponds to a new chess game *)
let new_game () : piece list = 
  [
  { piece=Rook; color=Black; first=true; row=0; col=0; rect=new_piece 0 0; img=get_img Rook Black };
  { piece=Knight; color=Black; first=true; row=0; col=1; rect=new_piece 0 1; img=get_img Knight Black};
  { piece=Bishop; color=Black; first=true; row=0; col=2; rect=new_piece 0 2; img=get_img Bishop Black };
  { piece=Queen; color=Black; first=true; row=0; col=3; rect=new_piece 0 3; img=get_img Queen Black };
  { piece=King; color=Black; first=true; row=0; col=4; rect=new_piece 0 4; img=get_img King Black};
  { piece=Bishop; color=Black; first=true; row=0; col=5; rect=new_piece 0 5; img=get_img Bishop Black };
  { piece=Knight; color=Black; first=true; row=0; col=6; rect=new_piece 0 6; img=get_img Knight Black };
  { piece=Rook; color=Black; first=true; row=0; col=7; rect=new_piece 0 7; img=get_img Rook Black };

  { piece=Pawn; color=Black; first=true; row=1; col=0; rect=new_piece 1 0; img=get_img Pawn Black };
  { piece=Pawn; color=Black; first=true; row=1; col=1; rect=new_piece 1 1; img=get_img Pawn Black };
  { piece=Pawn; color=Black; first=true; row=1; col=2; rect=new_piece 1 2; img=get_img Pawn Black };
  { piece=Pawn; color=Black; first=true; row=1; col=3; rect=new_piece 1 3; img=get_img Pawn Black };
  { piece=Pawn; color=Black; first=true; row=1; col=4; rect=new_piece 1 4; img=get_img Pawn Black };
  { piece=Pawn; color=Black; first=true; row=1; col=5; rect=new_piece 1 5; img=get_img Pawn Black };
  { piece=Pawn; color=Black; first=true; row=1; col=6; rect=new_piece 1 6; img=get_img Pawn Black };
  { piece=Pawn; color=Black; first=true; row=1; col=7; rect=new_piece 1 7; img=get_img Pawn Black };

  { piece=Pawn; color=White; first=true; row=6; col=0; rect=new_piece 6 0; img=get_img Pawn White };
  { piece=Pawn; color=White; first=true; row=6; col=1; rect=new_piece 6 1; img=get_img Pawn White };
  { piece=Pawn; color=White; first=true; row=6; col=2; rect=new_piece 6 2; img=get_img Pawn White };
  { piece=Pawn; color=White; first=true; row=6; col=3; rect=new_piece 6 3; img=get_img Pawn White };
  { piece=Pawn; color=White; first=true; row=6; col=4; rect=new_piece 6 4; img=get_img Pawn White };
  { piece=Pawn; color=White; first=true; row=6; col=5; rect=new_piece 6 5; img=get_img Pawn White };
  { piece=Pawn; color=White; first=true; row=6; col=6; rect=new_piece 6 6; img=get_img Pawn White };
  { piece=Pawn; color=White; first=true; row=6; col=7; rect=new_piece 6 7; img=get_img Pawn White };

  { piece=Rook; color=White; first=true; row=7; col=0; rect=new_piece 7 0; img=get_img Rook White };
  { piece=Knight; color=White; first=true; row=7; col=1; rect=new_piece 7 1; img=get_img Knight White };
  { piece=Bishop; color=White; first=true; row=7; col=2; rect=new_piece 7 2; img=get_img Bishop White };
  { piece=Queen; color=White; first=true; row=7; col=3; rect=new_piece 7 3; img=get_img Queen White };
  { piece=King; color=White; first=true; row=7; col=4; rect=new_piece 7 4; img=get_img King White };
  { piece=Bishop; color=White; first=true; row=7; col=5; rect=new_piece 7 5; img=get_img Bishop White };
  { piece=Knight; color=White; first=true; row=7; col=6; rect=new_piece 7 6; img=get_img Knight White };
  { piece=Rook; color=White; first=true; row=7; col=7; rect=new_piece 7 7; img=get_img Rook White }
  ]