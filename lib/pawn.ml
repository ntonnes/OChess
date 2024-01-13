open Pieces
open Globals


(* 
   Function: move_pawn
   Checks if the given vector (dx, dy) represents a valid movement for the given pawn.
   Parameters:
     - piece: The pawn piece
     - dx: Change in x-coordinate
     - dy: Change in y-coordinate
     - dst: The destination coordinate
   Returns: bool
*)
let move_pawn piece dx dy dst =

  (* Gets piece option at the destination tile *)
  let target () = 
    let pred p = dst = (!(p.row), !(p.col)) in
    List.find_opt pred !gs
  in

  (* Checks if the target is a valid capture *)
  let valid_capture piece = 
    match target() with
    | Some x when x.color <> piece.color -> true
    | _ -> false
  in

  (* Checks if the target it empty *)
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

