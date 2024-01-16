## OChess: an OCaml chess application
The implementation of the chess game logic itself is written entirely in standard OCaml. The GUI is written in OCaml using the [TSDL](https://github.com/dbuenzli/tsdl/) 
and associated packages [TSDL_image](https://github.com/tokenrove/tsdl-image) for importing textures, and [TSDL_ttf](https://github.com/tokenrove/tsdl-ttf) for rendering text. 
All source code is original and written from scratch by me, with the exception of 'log.ml' which is provided by the authors of TSDL. This file provides functions that print user input, assisting in error handling and debugging.

## Features
_failwith "TODO"_

## Installation
_failwith "TODO"_

## About
This is a personal project inspired by a class that I took in functional programming at McGill University. I enjoyed learning OCaml, 
and I wanted to make something larger than the assignments we had to complete for class. In light of my recent interest in improving in 
chess, I decided to make a simple chess application with OCaml. I had originally intended to use OCaml's graphics package for the GUI, but 
decided to use TSDL instead, which provides bindings for the C library Simple DirectMedia Layer (SDL) in OCaml. This provides more 
flexibility and simplifies the handling of user input and other complex features.
