open Globals
open Tsdl

let black_box = 
  Sdl.Rect.create ~x:(!offset_x+(!cell_size*8)+((!offset_x-200)/2)) ~y:20 ~w:200 ~h:200
;;

let white_box = 
  Sdl.Rect.create ~x:(!offset_x+(!cell_size*8)+((!offset_x-200)/2)) ~y:(!window_h-220) ~w:200 ~h:200
;;