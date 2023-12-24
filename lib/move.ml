(*
open Pieces
open Constants

type move = {
source : int * int; 
destination : int * int;
piece: piece; 
game_state : piece option array array
}

exception InvalidMove of string 

let is_within_board (x, y) = 
  x >= 0 && x < board_size && y >=0 && y < board_size
;;

let validate_destination move= 
  let dx = (fst move.destination)-(fst move.source) in
  let dy = (snd move.destination)-(snd move.source) in
  match move.piece with
    
  | King _ -> 
    if 1 = abs dx lor abs dy then () (* if moving one square *)
    (* TODO: implement castle *)
    else raise (InvalidMove "Naughty King")
            
  | Queen _ -> 
    if (dx = 0 && dy <> 0) || (dy = 0 && dx <> 0) then ()
    else if abs dx = abs dy then ()
    else raise (InvalidMove "Naughty Queen") 
            
  | Rook _ ->
    if (dx = 0 && dy <> 0) || (dy = 0 && dx <> 0) then () 
    (* TODO: implement castle *)
    else raise (InvalidMove ("Naughty Rook"))
            
  | Bishop _ -> 
    if abs dx = abs dy then ()
    else raise (InvalidMove ("Naughty Bishop")) 
            
  | Knight _ -> 
    if (abs dx = 1 && abs dy = 2) || (abs dy = 1 && abs dx = 2) then ()
    else raise (InvalidMove ("Naughty Knight"))
        
  | Pawn (_, first) -> 
    if first && dy = 2 && dx = 0 then ()
    else if dy = 1 && dx = 0 then ()
    (* TODO: handle capture *)
    (* TODO: implement en passent *)
    else raise (InvalidMove ("Naughty Pawn"))
  
    (*
  validate move
    - check that destination is valid xxx
    - check that path is clear
    - make sure king isnt in check
  *)
;;
*)