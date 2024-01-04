open Constants

let selected_cell x_coord y_coord= 
  let col = (x_coord - !offset_x) / !cell_size in
  let row = (y_coord - !offset_y) / !cell_size in
  (row, col)

let selected_piece x_coord y_coord = 
  let cell = selected_cell x_coord y_coord in
  