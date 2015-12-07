=begin
  # Our interface
  # (the `new` is implied)
  Class: Foo
      bar                         # from the attr_reader
      bim                         # from the attr_accessor
      bim=(new_value)             # from the attr_accessor
      do_something(some_input) 
  end
=end

Class: TicTacToe
    play
    game_over
    check_victory
    check_draw
    switch_players
end

Class: Player
    name
    name=(new_value)
    piece
    piece=(new_value)
    is INITIALIZE ONE? Because you have to put in arguments.
    get_coordinates
    ask_for_coordinates
    valid_coordinates_format(coords)
end

Class: Board
    render
    add_piece(coords, piece)
    piece_location_valid?(coords)
    within_valid_coordinates?(coords)
    coordinates_available?(coords)
    winning_combination?(piece)
    winning_diagonal?(piece)
    winning_vertical?(piece)
    winning_horizontal?(piece)
    diagonals
    verticals
    horizontals
    full?
end