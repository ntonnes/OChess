open Pieces 
open Constants

let new_board =
  let pieces = Array.make_matrix board_size board_size None in
  pieces.(0).(0) <- Some (Rook (Black, true));
  pieces.(0).(1) <- Some (Knight Black);
  pieces.(0).(2) <- Some (Bishop Black);
  pieces.(0).(3) <- Some (Queen Black);
  pieces.(0).(4) <- Some (King (Black, true));
  pieces.(0).(5) <- Some (Bishop Black);
  pieces.(0).(6) <- Some (Knight Black);
  pieces.(0).(7) <- Some (Rook (Black, true));

  pieces.(1).(0) <- Some (Pawn (Black, true));
  pieces.(1).(1) <- Some (Pawn (Black, true));
  pieces.(1).(2) <- Some (Pawn (Black, true));
  pieces.(1).(3) <- Some (Pawn (Black, true));
  pieces.(1).(4) <- Some (Pawn (Black, true));
  pieces.(1).(5) <- Some (Pawn (Black, true));
  pieces.(1).(6) <- Some (Pawn (Black, true));
  pieces.(1).(7) <- Some (Pawn (Black, true));

  pieces.(6).(0) <- Some (Pawn (White, true));
  pieces.(6).(1) <- Some (Pawn (White, true));
  pieces.(6).(2) <- Some (Pawn (White, true));
  pieces.(6).(3) <- Some (Pawn (White, true));
  pieces.(6).(4) <- Some (Pawn (White, true));
  pieces.(6).(5) <- Some (Pawn (White, true));
  pieces.(6).(6) <- Some (Pawn (White, true));
  pieces.(6).(7) <- Some (Pawn (White, true));

  pieces.(7).(0) <- Some (Rook (White, true));
  pieces.(7).(1) <- Some (Knight White);
  pieces.(7).(2) <- Some (Bishop White);
  pieces.(7).(3) <- Some (Queen White);
  pieces.(7).(4) <- Some (King (White, true));
  pieces.(7).(5) <- Some (Bishop White);
  pieces.(7).(6) <- Some (Knight White);
  pieces.(7).(7) <- Some (Rook (White, true));
  
  pieces