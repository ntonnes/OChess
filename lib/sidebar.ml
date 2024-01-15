open Tsdl
open Tsdl_ttf
open Globals
open Utils
open Pieces


(** [render_text size text x y] renders the specified text onto the screen at the given coordinates.
    The function loads a font, renders the text onto a surface, creates a texture from the surface,
    and finally renders the texture on the screen using the specified renderer. The text is centered
    at the provided coordinates.

    @param size The font size for rendering the text.
    @param text The text string to render.
    @param x The x-coordinate for the center of the rendered text.
    @param y The y-coordinate for the rendered text.
    @requires The global state variables and functions related to SDL, TTF, and rendering operations.
    @ensures The specified text is rendered on the screen at the given coordinates.
*)
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
    | Error (`Msg e) -> Sdl.log "Surface creation error: %s" e; exit 1
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


(** [render_info_text ()] renders all text to the screen.
    The function displays whose turn it is (Black or White) and also renders headers for the capture lists
    for both Black and White players. The text is positioned on the screen using predefined offsets.
    @requires The global state variables [turn], [offset_x], [cs], and [captures_black] and [captures_white] lists.
    @ensures Textual information is rendered on the screen.
*)
let render_info_text () = 
  let text = 
    match !turn with
    | Black -> "Black's Turn"
    | White -> "White's Turn"
  in
  render_text 28 text (!offset_x/2) 40;
  render_text 25 "Reset" (!offset_x/2) (!window_h - 72);
  render_text 20 "Black's Captures" (!offset_x + (!offset_x/2) + (!cs*8)) 20;
  render_text 20 "White's Captures" (!offset_x + (!offset_x/2) + (!cs*8)) ((!window_h/2)+20);
;;


(** [render_capture piece acc_w acc_h] renders a captured chess piece on the screen.
    The function loads the texture corresponding to the given [piece], creates a rectangle for rendering,
    and then pastes the texture onto the screen.
    @param piece The chess piece to be rendered.
    @param acc_w The accumulated width offset for positioning.
    @param acc_h The accumulated height offset for positioning.
    @requires The global state variable [offset_x] and [cs].
    @ensures The captured chess piece is rendered on the screen.
*)
let render_capture piece acc_w acc_h = 
  let tex = load_tex (file_of_piece piece) in
  let rect = 
    Sdl.Rect.create ~x:(!offset_x+(!cs*8)+10+acc_w) ~y:acc_h ~w:40 ~h:40
  in
  paste_tex tex rect;
;;


(** [render_captures ()] renders the captured chess pieces on the screen.
    The function iterates through the lists of captured pieces for Black and White players,
    rendering each piece using [render_capture]. The pieces are arranged in rows with a predefined spacing.
    @requires The global state variables [captures_black], [captures_white], [offset_x], [cs], and [window_h].
    @ensures Captured chess pieces are rendered on the screen.
*)
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


(** [render_sidebars ()] renders the sidebars on the screen.
    The function creates rectangles for the left and right sidebars and fills them with a gray color.
    It then calls [render_info_text] and [render_captures] to populate the sidebars on the screen.
    @requires The global state variables [offset_x], [cs], [captures_black], [captures_white], and [window_h].
    @ensures Sidebars are rendered on the screen.
*)
let render_sidebars () =
  let render_buttons () = 
    let reset_border = Sdl.Rect.create ~x:((!offset_x)/6) ~y:(!window_h-80) ~w:(4*((!offset_x)/6) + 5) ~h:(((!cs)/2)+5) in
    let reset = Sdl.Rect.create ~x:((!offset_x)/6) ~y:(!window_h-80) ~w:(4*((!offset_x)/6)) ~h:((!cs) /2) in
    draw_rect 120 120 120 255 reset_border;
    draw_rect 160 160 160 255 reset;
  in
  let right = Sdl.Rect.create ~x:(!offset_x+(!cs*8)) ~y:0 ~w:(!offset_x) ~h:(!cs *8) in
  let left = Sdl.Rect.create ~x:0 ~y:0 ~w:(!offset_x) ~h:(!cs * 8) in
  List.iter (draw_rect 184 133 82 255) [left; right];
  render_buttons();
  render_info_text();
  render_captures();
;;