open Tsdl
open Pieces
open Log
open Tsdl.Sdl.Message_box
open Globals
open Board


(** [new_game ()] initializes a new chess game by resetting the game state, including the chessboard, turn, and captures.
    It sets the initial turn to [White] and clears any previous winner information.
*)
let new_game () = 
  gs := new_board ();
  turn := White;
  victor := None;
  last_move := [];
  captures_white := [];
  captures_black := []
;;


(** [game_over()] checks if the game is over by determining if there is a winner.
    @return [true] if there is a winner, [false] otherwise.
*)
let game_over() = !victor <> None


(** [winner color] displays a popup message box with the winning message and options to start a new game or exit.
    It updates the game state based on the user's choice.
    @param color The color of the winner ([Black] or [White]).
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
    window = (None);
    title = "Checkmate!";
    message = message;
    buttons = buttons;
    color_scheme = None }
  with
  | Error (`Msg e) -> log_err " Could not show message box %s: %s" "Game Over" e;
  | Ok result ->
    match result with
    | 1 -> new_game ()
    | 2 -> ();
    | _ -> ()
