# mastermind
# 4 colors, 4 pegs
# 12 turns to crack code
#   win condition
#   lose condition
# Player class
#   validate format
# Computer class
#   random colors
# Human class
#   input colors
#   guess
# Board class
#   holds the key
#   render board
#   check guesses

class Mastermind

  def initialize(players)
    @board = Board.new
    @player1 = Human.new(@board)
    if players == 2
      @player2 = Human.new(@board)
    else
      @player2 = Computer.new(@board)
    end
  end

  def play
    @player2.input_colors
    until finish?
    @board.check_accuracy(@player1.get_guess)
    end
  end

  def finish?
    win? || lose?
  end

  def win?
    @board.correct?
  end

  def lose?
    @board.guesses >= 12
  end


end