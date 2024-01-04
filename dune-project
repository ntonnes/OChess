(lang dune 3.12)

(name chess)
(version 18aaa6d-dirty)

(generate_opam_files true)

(source
 (github ntonnes/ocaml-chess))

(authors "Noah Tonnesen")

(maintainers "Noah Tonnesen")

(license LICENSE)

(documentation "https://ntonnes.github.io/ocaml-chess/")

(package
 (name chess)
 (synopsis "A chess implementation using OCaml and SDL")
 (description "This is a personal project inspired by a class I took in functional programming. 
 I wanted to try working with large OCaml projects beyond the small assignments done for the class. 
 I am also gaining experience with SDL by using TSDL to create the graphics, a package which implements SDL commands in OCaml.")
 (depends ocaml dune tsdl)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
