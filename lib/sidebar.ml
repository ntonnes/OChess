open Tsdl
open Tsdl_ttf
open Globals
open Utils
open Pieces



(*function*)
let render_text size text x y=
  let get_texture_dimensions tex =
    let f = fun (_, _, (c, d)) -> (c, d) in
    f (query_tex tex)
  in
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
    let dst_rect = Sdl.Rect.create ~x:(x - (fst dims/2)) ~y:y ~w:(fst dims) ~h:(snd dims) in
    ignore (Sdl.render_copy rend texture ~dst:dst_rect);
    Sdl.destroy_texture texture;
    Sdl.free_surface surface
  ;;
;;


(*function*)
let render_info_text () = 
  let text = 
    match !turn with
    | Black -> "Black's Turn"
    | White -> "White's Turn"
  in
  render_text 28 text (!offset_x/2) 20;
  render_text 20 "Black's Captures" (!offset_x + (!offset_x/2) + (!cs*8)) 20;
  render_text 20 "White's Captures" (!offset_x + (!offset_x/2) + (!cs*8)) ((!window_h/2)+20);
;;


(*function*)
let render_capture piece acc_w acc_h = 
  let tex = load_tex (file_of_piece piece) in
  let rect = 
    Sdl.Rect.create ~x:(!offset_x+(!cs*8)+10+acc_w) ~y:acc_h ~w:40 ~h:40
  in
  paste_tex tex rect;
;;


(*function*)
let render_captures ()=
  let rec go ls acc_w acc_h = 
    match ls with
    | [] -> ()
    | (piece :: pieces) -> 
      render_capture piece acc_w acc_h;
      if acc_w = 150 then
        go pieces 0 (acc_h+40) 
      else 
        go pieces (acc_w+30) acc_h 
  in
  go !captures_black 0 60 ;
  go !captures_white 0 ((!window_h/2)+60)
;;


(*function*)
let render_sidebars () =
  let right = Sdl.Rect.create ~x:(!offset_x+(!cs*8)) ~y:0 ~w:(!offset_x) ~h:(!cs *8) in
  let left = Sdl.Rect.create ~x:0 ~y:0 ~w:(!offset_x) ~h:(!cs * 8) in
  List.iter (draw_rect 118 118 118 255) [left; right];
  render_info_text();
  render_captures();
;;