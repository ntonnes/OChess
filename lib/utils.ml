open Tsdl
open Globals
open Tsdl_image


(** [quit_game ()] quits the game by destroying the window, renderer, and quitting SDL.
    Exits the program with code 0.
    @raise [Sdl_error] if there is an error during the quit process.
*)
let quit_game() =
  let window, renderer = get_window(), get_rend() in
  Sdl.destroy_renderer renderer; 
  Sdl.destroy_window window;
  Sdl.quit();
  exit 0;
;;


(** [set_window w] sets the game window reference to the specified window.
    @param w The window to set as the game window reference.
*)
let set_window w = window := (Some w);;


(** [set_renderer r] sets the SDL renderer reference to the specified renderer.
    @param r The renderer to set as the SDL renderer reference.
*)
let set_renderer r = rend := (Some r);;


(** [load_tex file] loads a texture from the specified file using the SDL image bindings.
    @param file The file path of the texture.
    @return The loaded texture.
    @raise [Sdl_error] if there is an error loading the texture.
*)
let load_tex file = 
  let rend = get_rend() in
  match Image.load_texture rend file with
    | Error (`Msg e) -> Sdl.log_error 0 "Load texture error: %s" e; exit 1 
    | Ok tex -> tex
;;


(** [paste_tex tex dst] pastes a texture onto the renderer at the specified destination rectangle.
    It also destroys the texture after pasting.
    @param tex The texture to be pasted.
    @param dst The destination rectangle where the texture is pasted.
    @raise [Sdl_error] if there is an error pasting the texture.
*)
let paste_tex tex dst = 
  let rend = get_rend() in
  match Sdl.render_copy rend tex ~dst:dst with
  | Error (`Msg e) -> Sdl.destroy_texture tex; Sdl.log_error 0 "Render texture error: %s" e; exit 1
  | Ok () -> Sdl.destroy_texture tex
;;


(** [query_tex tex] queries the dimensions of a texture.
    @param tex The texture to query.
    @return The query result containing texture information.
    @raise [Sdl_error] if there is an error querying the texture.
*)
let query_tex tex = 
  match Sdl.query_texture tex with 
  | Error (`Msg e) -> Sdl.log "texture loading error: %s" e; exit 1
  | Ok query -> query
;;


(** [draw_rect r g b a rect] draws a filled rectangle on the renderer with the specified color and transparency.
    @param r The red component of the color (0-255).
    @param g The green component of the color (0-255).
    @param b The blue component of the color (0-255).
    @param a The alpha (transparency) component of the color (0-255).
    @param rect The rectangle defining the position and size of the filled rectangle.
    @raise [Sdl_error] if there is an error drawing the rectangle.
*)
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
