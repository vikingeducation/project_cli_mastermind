## Tic Tac Toe Interfaces

Class:  TicTacToe
* play
* check_game_over
* check_victory
* check_draw
* switch_players

Class:  Player
* name
* name=(new value)
* piece
* piece=(new value)
* get_coordinates
* ask_for_coordinates
* validate_coordinates_format(some input)

Class:  Board
* board_arr
* render
* add_piece(some 2 inputs)
* piece_location_valid?(some input)
* within_valid_coordinates?(some input)
* coordinates_available?(some input)
* winning_combination?(some input)
* winning_diagonal?(some input)
* winning_vertical?(some input)
* winning_horizontal?(some input)
* diagonals
* verticals
* horizontals
* full?