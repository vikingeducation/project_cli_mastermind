class Board
  # COLORS
  @game_turns = 12

  attr_reader :pegs, :colors, :moves

  def initialize(player)
    # number of turns
    @player_turns = 0
    # array of moves
    @moves = []
    # get number of pegs [ask player]
    @pegs = player.get_pegs
    # get number of colors
    @colors = set_colors(player.get_colors)
  end

  # render
    # start as number_of_turns lines
    # array of pegs with color
    # go through each move so far and print that line, plus feedback for that line

  #  move
    # add move to board

  def set_colors(number_of_colors)
    $COLORS.keys.sample(number_of_colors)
  end 

  # give feedback
    # look at current turn
      # count number of correct, half-correct, and wrong
    # return

  #check for game over
    # did they win?
    # are the moves over?

  # win?

  # moves left?

end