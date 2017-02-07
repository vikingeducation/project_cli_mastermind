# Maintains game board state
class Board
  # initialize board
    # set up blank data structure

  # render
    # loop through data structure
      # display an existing peg if any, else blank

  # set_code
    # IF valid_code?
      # set code
    # ELSE
      # display error message

  # add_guess
    # IF valid_code?
      # place guess
    # ELSE
      # display error message

  # valid_code?
    # is each peg in the code a valid_color?

  # valid_color?
    # is the peg included in the list of valid_colors?

  # close_pegs
    # number of pegs in the guess with correct color, but incorrect location

  # exact_pegs
    # number of pegs in the guess with correct color, and correct location

  # winning_combination?
    # does the guess have 4 exact_pegs?

  # full?
    # does every row contain a guess?
end