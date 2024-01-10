open Tsdl
open Pieces
open Log
open Tsdl.Sdl.Message_box
open Globals

open Board


let new_game () = 
  gs := new_board ();
  turn := White;
  victor := None;
;;


(* 
   Function: win
   Displays a message box declaring the winner
   Asks if the user would like to quit or start a new game
   Parameters:
     - color: The color of the winner
   Returns: unit
*)

let winner color =
  let message =
    match color with
    | Black -> "Black wins!"
    | White -> "White wins!"
  in
  let buttons = [
    {button_flags = button_returnkey_default; button_id = 1; button_text = "New Game"}; 
    {button_flags = button_escapekey_default; button_id = 2; button_text = "Exit"}] 
  in

  (* Display popup with the winning message and options *)
  match Sdl.show_message_box { 
    flags = information;
    window = None;
    title = "Game Over";
    message = message;
    buttons = buttons;
    color_scheme = None }
  with
  | Error (`Msg e) -> log_err " Could not show message box %s: %s" "Game Over" e;
  | Ok result ->
    match result with
    | 1 -> new_game ()
    | 2 -> exit 0;
    | _ -> ()
