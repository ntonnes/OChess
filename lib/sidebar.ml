open Tsdl
open Globals
open Tsdl_ttf

let render_left () =
  let rend = get_rend () in
  let rect = Sdl.Rect.create ~x:0 ~y:0 ~w:(!offset_x) ~h:(!window_h) in
  Sdl.set_render_draw_color rend 118 118 118 255 |> ignore;
  Sdl.render_fill_rect rend (Some rect) |> ignore
;;

let render_right () =
  let rend = get_rend () in
  let rect = Sdl.Rect.create ~x:(!offset_x+(!cell_size*8)) ~y:0 ~w:(!offset_x) ~h:(!window_h) in
  Sdl.set_render_draw_color rend 118 118 118 255 |> ignore;
  Sdl.render_fill_rect rend (Some rect) |> ignore
;;

let render_sidebars () =
  render_right ();
  render_left ();
;;

let get_texture_dimensions texture =
  match Sdl.query_texture texture with 
  | Error (`Msg e) -> Sdl.log "Font loading error: %s" e; exit 1
  | Ok query ->
    let f = fun (_, _, (c, d)) -> (c, d) in
    f query
  ;;
;;

let render_text size text =
  let font =
    match Ttf.open_font ("./assets/bold700.ttf") size with
    | Error (`Msg e) -> Sdl.log "Font loading error: %s" e; exit 1
    | Ok font -> font
  in
  let rend = get_rend () in
  let surface = 
    match Ttf.render_text_solid font text (Sdl.Color.create ~r:255 ~g:255 ~b:255 ~a:255) with
    | Error (`Msg e) -> Sdl.log "Font loading error: %s" e; exit 1
    | Ok surface -> surface
  in
  match Sdl.create_texture_from_surface rend surface with
  | Error (`Msg e) -> Sdl.log "Texture creation error: %s" e; exit 1
  | Ok texture ->
    let dims = get_texture_dimensions texture in
    let dst_rect = Sdl.Rect.create ~x:(((!offset_x- fst dims))/2) ~y:20 ~w:(fst dims) ~h:(snd dims) in
    ignore (Sdl.render_copy rend texture ~dst:dst_rect);
    Sdl.destroy_texture texture;
    Sdl.free_surface surface
  ;;
;;

let render_turn_text () = 
  let text = 
    match !turn with
    | Black -> "Black's Turn"
    | White -> "White's Turn"
  in
  render_text 28 text