open Tsdl
open Pieces
open Constants

(* create a new renderer for the chess board in the background *)
let draw_chessboard renderer =

  for row = 0 to 7 do
    for col = 0 to 7 do

      let rect = Sdl.Rect.create ~x:(col * cell_size) ~y:(row * cell_size) ~w:cell_size ~h:cell_size in
      if (row + col) mod 2 = 0 then
        Sdl.set_render_draw_color renderer 255 206 158 255 |> ignore
      else
        Sdl.set_render_draw_color renderer 209 139 71 255 |> ignore;
      Sdl.render_fill_rect renderer (Some rect) |> ignore;

    done;
  done

let draw_pieces renderer board =

  for row = 0 to board_size - 1 do
    for col = 0 to board_size -1 do

      let rect = Sdl.Rect.create ~x:0 ~y:0 ~w:cell_size ~h:cell_size in
      match (board).(row).(col) with

      | None -> ()

      | Some (Pawn _) ->
        (* pawn = red *)
        Sdl.set_render_draw_color renderer 255 0 0 255 |> ignore;
        Sdl.Rect.set_x rect (col * cell_size);
        Sdl.Rect.set_y rect (row * cell_size);
        Sdl.render_fill_rect renderer (Some rect) |> ignore;

        | Some (Rook _) ->
          (* rook = blue *)
          Sdl.set_render_draw_color renderer 0 0 255 255 |> ignore;
          Sdl.Rect.set_x rect (col * cell_size);
          Sdl.Rect.set_y rect (row * cell_size);
          Sdl.render_fill_rect renderer (Some rect) |> ignore;
  
        | Some (Bishop _) ->
          (* bishop = green *)
          Sdl.set_render_draw_color renderer 0 255 0 255 |> ignore;
          Sdl.Rect.set_x rect (col * cell_size);
          Sdl.Rect.set_y rect (row * cell_size);
          Sdl.render_fill_rect renderer (Some rect) |> ignore;
  
        | Some (Knight _) ->
          (* knight = yellow *)
          Sdl.set_render_draw_color renderer 255 255 0 255 |> ignore;
          Sdl.Rect.set_x rect (col * cell_size);
          Sdl.Rect.set_y rect (row * cell_size);
          Sdl.render_fill_rect renderer (Some rect) |> ignore;
  
        | Some (Queen _) ->
          (* queen = purple *)
          Sdl.set_render_draw_color renderer 128 0 128 255 |> ignore;
          Sdl.Rect.set_x rect (col * cell_size);
          Sdl.Rect.set_y rect (row * cell_size);
          Sdl.render_fill_rect renderer (Some rect) |> ignore;
  
        | Some (King _) ->
          (* king = orange *)
          Sdl.set_render_draw_color renderer 255 165 0 255 |> ignore;
          Sdl.Rect.set_x rect (col * cell_size);
          Sdl.Rect.set_y rect (row * cell_size);
          Sdl.render_fill_rect renderer (Some rect) |> ignore;

      done
  done