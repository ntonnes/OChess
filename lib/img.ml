open Tsdl
open Pieces
open Tsdl_image
open Constants



(* create a rect with the same dimensions as the a cell at (row,col) *)
let new_piece row col = Sdl.Rect.create 
  ~x:((col * !cell_size) + (!cell_size/10) + !offset_x) 
  ~y:((row * !cell_size) + (!cell_size/10) + !offset_y) 
  ~w:(!cell_size - (!cell_size/5)) 
  ~h:(!cell_size - (!cell_size/5)) 
;;



(* renders a piece's corresponding texture at the piece's position *)
let render_texture renderer piece = 

  (* load corresponding image as a texture *)
  let tex_opt = 
    match piece.piece, piece.color with
    | King, Black -> Image.load_texture renderer "./assets/black_king.png"
    | King, White -> Image.load_texture renderer "./assets/white_king.png"
    | Queen, Black -> Image.load_texture renderer "./assets/black_queen.png"
    | Queen, White -> Image.load_texture renderer "./assets/white_queen.png"
    | Bishop, Black -> Image.load_texture renderer "./assets/black_bishop.png"
    | Bishop, White -> Image.load_texture renderer "./assets/white_bishop.png"
    | Knight, Black -> Image.load_texture renderer "./assets/black_knight.png"
    | Knight, White -> Image.load_texture renderer "./assets/white_knight.png"
    | Rook, Black -> Image.load_texture renderer "./assets/black_rook.png"
    | Rook, White -> Image.load_texture renderer "./assets/white_rook.png"
    | Pawn, Black -> Image.load_texture renderer "./assets/black_pawn.png"
    | Pawn, White -> Image.load_texture renderer "./assets/white_pawn.png"
  in

  (* check if load was successful *)
  let tex = 
    match tex_opt with
    | Error (`Msg e) -> Sdl.log_error 0 "Create texture error: %s" e; exit 1 
    | Ok tex -> tex
  in

  (* create rect at piece's location *)
  let rect = new_piece piece.row piece.col in

  (* render texture into the new rect *)
  Sdl.render_copy renderer tex ~dst:rect |> ignore;
;;