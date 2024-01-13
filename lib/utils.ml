open Tsdl
open Globals
open Tsdl_image


let quit_game() =
  let window, renderer = get_window(), get_rend() in
  Sdl.destroy_renderer renderer; 
  Sdl.destroy_window window;
  Sdl.quit();
  exit 0;
;;

let set_window w = window := (Some w);;

let set_renderer r = rend := (Some r)
;;

let load_tex file = 
  let rend = get_rend() in
  match Image.load_texture rend file with
    | Error (`Msg e) -> Sdl.log_error 0 "Load texture error: %s" e; exit 1 
    | Ok tex -> tex
;;

let paste_tex tex dst = 
  let rend = get_rend() in
  match Sdl.render_copy rend tex ~dst:dst with
  | Error (`Msg e) -> Sdl.destroy_texture tex; Sdl.log_error 0 "Render texture error: %s" e; exit 1
  | Ok () -> Sdl.destroy_texture tex
;;

let query_tex tex = 
  match Sdl.query_texture tex with 
  | Error (`Msg e) -> Sdl.log "texture loading error: %s" e; exit 1
  | Ok query -> query
;;

let draw_rect r g b a rect= 
  let rend = get_rend() in
  match Sdl.set_render_draw_blend_mode rend Sdl.Blend.mode_blend with
  | Error (`Msg e) -> Sdl.log_error 0 "Set blend mode error: %s" e; exit 1
  | Ok () -> ();
  match Sdl.set_render_draw_color rend r g b a with
  | Error (`Msg e) -> Sdl.log_error 0 "Set draw color error: %s" e; exit 1
  | Ok () -> ();
  match Sdl.render_fill_rect rend (Some rect) with
  | Error (`Msg e) -> Sdl.log_error 0 "Fill rect error: %s" e; exit 1
  | Ok () -> ();
;;
