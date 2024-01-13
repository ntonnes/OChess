open Globals
open Tsdl
open Tsdl_image
open Pieces

let black_capture acc_w acc_h = 
  Sdl.Rect.create ~x:(!offset_x+(!cell_size*8)+10+acc_w) ~y:acc_h ~w:40 ~h:40
;;

let white_capture acc_w acc_h = 
  Sdl.Rect.create ~x:(!offset_x+(!cell_size*8)+10+acc_w) ~y:((!window_h/2)+acc_h) ~w:40 ~h:40
;;

let render_capture piece color acc_w acc_h = 
  let rend = get_rend() in

  (* load corresponding image as a texture *)
  let tex = match Image.load_texture rend ("./assets/"^(string_of_piece piece)^".png") with
    | Error (`Msg e) -> Sdl.log_error 0 "Create texture error: %s" e; exit 1 
    | Ok tex -> tex
  in

  (* create rect at correct location *)
  let rect = match color with
  | White -> white_capture acc_w acc_h
  | Black -> black_capture acc_w acc_h
  in

  (* render texture into the new rect *)
  Sdl.render_copy rend tex ~dst:rect |> ignore;
  Sdl.destroy_texture tex;
;;

let render_captures ()=
  let rec go ls acc_w acc_h color = 
    match ls with
    | [] -> ()
    | (piece :: pieces) -> 
      render_capture piece color acc_w acc_h;
      if acc_w = 150 then
        go pieces 0 (acc_h+40) color
      else 
        go pieces (acc_w+30) acc_h color
  in
  go !captures_black 0 60 Black;
  go !captures_white 0 60 White