open Tsdl
open Pieces


(* References for pixel navigation. *)
let cs = ref 100 ;;
let window_w = ref (!cs * 8) ;;
let window_h = ref (!cs * 8) ;;
let offset_x = ref 0 ;;
let offset_y = ref 0 ;;


(* References for application. *)
let window : Sdl.window option ref = ref None ;;
let rend : Sdl.renderer option ref = ref None ;;


(* References for gameplay. *)
let selected : piece option ref = ref None ;;
type game_state = piece list ;;
let gs : game_state ref = ref [] ;;
let turn : color ref = ref White ;;
let victor : color option ref = ref None ;;
let captures_black : piece list ref = ref [] ;;
let captures_white : piece list ref = ref [] ;;
let last_move : (int*int) list ref = ref [] ;;


(** [opp color] returns the opposite color.
    @param color The input color (Black or White).
    @return The opposite color.
*)
let opp color = 
  match color with
  | Black -> White
  | White -> Black
;;


(** [get_window ()] returns the game window reference.
    @return The game window reference.
    @raise [Sdl_error] if the window reference is [None].
*)
let get_window () = 
  match !window with
  | None -> Sdl.log_error 0 "Error while getting window"; exit 1
  | Some window -> window
;;


(** [get_rend ()] returns the SDL renderer reference.
    @return The SDL renderer reference.
    @raise [Sdl_error] if the renderer reference is [None].
*)
let get_rend () = 
  match !rend with
  | None -> Sdl.log_error 0 "Error while getting renderer"; exit 1
  | Some renderer -> renderer
;;


(** [update_constants ()] updates the global constants based on the current window size.
    Calculates the new chess square size, horizontal and vertical offsets.
*)
let update_constants () = 
  let (w, h) = Sdl.get_window_size (get_window ()) in
  window_w := w; 
  window_h := h; 
  cs := (min w h)/8;
  offset_x := ((w - (!cs *8)) / 2);
  offset_y := ((h - (!cs *8)) / 2);
;;


(** [end_turn ()] switches the current turn between Black and White. 
*)
let end_turn () = 
  match !turn with
  | Black -> turn := White
  | White -> turn := Black
;;
