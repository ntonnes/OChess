open Tsdl
open Pieces


let cell_size = ref 100
let board_size = 8
let window_width = ref (!cell_size * board_size)
let window_height = ref (!cell_size * board_size)
let offset_x = ref 0
let offset_y = ref 0
let selected : piece option ref = ref None
type game_state = piece list
let gs : game_state ref = ref []

let interface () : bool array array = 
  let arr = Array.make_matrix 8 8 false in
  let update p = arr.(!(p.row)).(!(p.col)) <- true in
  List.iter update !gs;
  arr
;;

let update_constants window = 
  match Sdl.get_window_size window with
  | (w, h) -> 
    window_width := w; 
    window_height := h; 
    cell_size := (min w h)/8;
    offset_x := (w - (!cell_size *8)) / 2;
    offset_y := (h - (!cell_size *8)) / 2;
;;