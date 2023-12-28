open Tsdl
open Pieces
open Tsdl_image

let get_img piece_type color = 
  Image.Init.(png) |> ignore;

  let img =
    match piece_type, color with
    | King, Black -> Image.load "./assets/black_king.png"
    | King, White -> Image.load "./assets/white_king.png"
    | Queen, Black -> Image.load "./assets/black_queen.png"
    | Queen, White -> Image.load "./assets/white_queen.png"
    | Bishop, Black -> Image.load "./assets/black_bishop.png"
    | Bishop, White -> Image.load "./assets/white_bishop.png"
    | Knight, Black -> Image.load "./assets/black_knight.png"
    | Knight, White -> Image.load "./assets/white_knight.png"
    | Rook, Black -> Image.load "./assets/black_rook.png"
    | Rook, White -> Image.load "./assets/white_rook.png"
    | Pawn, Black -> Image.load "./assets/black_pawn.png"
    | Pawn, White -> Image.load "./assets/white_pawn.png"
  in
  
  match img with
  | Error (`Msg e) -> Sdl.log_error 0 "Get asset error: %s" e; exit 1
  | Ok image -> image