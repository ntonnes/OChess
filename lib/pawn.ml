open Pieces


(** [move_pawn piece dx dy dst] checks if a pawn move is valid based on its color and destination coordinates.
    It considers the initial two-square move, regular one-square move, and diagonal capture moves.
    @param piece The pawn piece to be moved.
    @param dx The change in the row position (positive for forward, negative for backward).
    @param dy The change in the column position (positive for right, negative for left).
    @param dst The destination coordinates (row, col) on the chessboard.
    @param gs The list of chess pieces representing the current game state.
    @return [true] if the move is valid, [false] otherwise.
*)
let move_pawn piece dx dy dst gs =

  (* Gets piece at the destination tile *)
  let target () = 
    let pred p = dst = (!(p.row), !(p.col)) in
    List.find_opt pred gs
  in

  (* Checks if the target is a valid capture *)
  let valid_capture piece = 
    match target() with
    | Some x when x.color <> piece.color -> true
    | _ -> false
  in

  (* Checks if the target is empty *)
  let valid_fwd () = 
    match target() with
    | None -> true
    | _ -> false
  in
  
  begin 
  if piece.color = White then 
    (* White pawn moving forward *)
    if (!(piece.first) && dx=2 && dy=0) || (dx=1 && dy=0)
      then valid_fwd ()
    (* White pawn capturing diagonal *)
    else (dx=1) && (abs dy=1) && (valid_capture piece)

  else
    (* Black pawn moving forward *)
    if !(piece.first) && (dx=(-2)) && (dy=0) || (dx=(-1)) && (dy=0) 
      then valid_fwd ()
    (* Black pawn capturing diagonal *)
    else (dx=(-1)) && (abs dy=1) && (valid_capture piece )
  end
;;

