# require_relative 'player.rb'

class Breaker #< Player
  attr_accessor :guess_board, :name, :current_guess

  def initialize
    @guess_board = Board.new
    @name = "Code Breaker"
    @guess = []
  end

  def guess

    @current_guess = get_code_input
    @guess_board[@guess_board.find_index(Array.new(4))] = @current_guess
  end
end

###################################

# def test
#   newboard = Array.new(2){Array.new(4)}
#   p newboard
#   input = %w[r b g y]
#   newboard[newboard.find_index(Array.new(4))] = input
#   p newboard
# end
#
# test
