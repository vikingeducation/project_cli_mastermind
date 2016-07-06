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
    @player1 = Human.new
    if players == 2
      @player2 = Human.new
    else
      @player2 = Computer.new
    end
  end


  def end?
  end
  def win?
  end
  def lose?
  end


end