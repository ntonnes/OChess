open Tsdl
open Pieces
open Log


(* 
   Function: win
   Displays a message box declaring the winner.
   Parameters:
     - color: The color of the winner
   Returns: unit
*)
let win color = 
  let message =
    match color with
    | Black -> "Black wins!"
    | White -> "White wins!"
  in
  let show title msg =
    match Sdl.show_simple_message_box Sdl.Message_box.information ~title msg None with
    | Error (`Msg e) -> log_err " Could not show message box %s: %s" title e
    | Ok () -> ()
  in
  show "Game Over" message
;;