open Tsdl

let cell_size = ref 100
let board_size = 8
let window_width = ref (!cell_size * board_size)
let window_height = ref (!cell_size * board_size)
let offset_x = ref 0
let offset_y = ref 0

let update_constants window = 
  match Sdl.get_window_size window with
  | (w, h) -> 
    window_width := w; 
    window_height := h; 
    cell_size := (min w h)/8;
    offset_x := (!window_width - (!cell_size *8)) / 2;
    offset_y := (!window_height - (!cell_size *8)) / 2;
;;