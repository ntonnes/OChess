open Tsdl
open Pieces


(* Constants for navigation *)
let cell_size = ref 100
let board_size = 8
let window_w = ref (!cell_size * board_size)
let window_h = ref (!cell_size * board_size)
let offset_x = ref 0
let offset_y = ref 0

(* Useful global valiables *)
let window : Sdl.window option ref = ref None
let rend : Sdl.renderer option ref = ref None
let selected : piece option ref = ref None
type game_state = piece list
let gs : game_state ref = ref []
let turn : color ref = ref White
let victor : color option ref = ref None
let captures_black : piece list ref = ref []
let captures_white : piece list ref = ref []


(* 
   Function: get_window
   Retrieves the SDL window; exits with an error if the window is not available.
   Returns: SDL window
*)
let get_window () = 
  match !window with
  | None -> Sdl.log_error 0 "Error while getting window"; exit 1
  | Some window -> window
;;


(* 
   Function: get_rend
   Retrieves the SDL renderer; exits with an error if the renderer is not available.
   Returns: SDL renderer
*)
let get_rend () = 
  match !rend with
  | None -> Sdl.log_error 0 "Error while getting renderer"; exit 1
  | Some renderer -> renderer
;;

(* 
   Function: update_constants
   Updates global navigation variables based on the current window size.
   Returns: none
*)
let update_constants () = 
  let (w, h) = Sdl.get_window_size (get_window ()) in
  window_w := w; 
  window_h := h; 
  cell_size := (min w h)/8;
  offset_x := ((w - (!cell_size *8)) / 2);
  offset_y := ((h - (!cell_size *8)) / 2);
;;


(* 
   Function: end_turn
   Changes the variable tracking whose turn it currently is.
   Returns: none
*)
let end_turn () = 
  match !turn with
  | Black -> turn := White
  | White -> turn := Black
;;
