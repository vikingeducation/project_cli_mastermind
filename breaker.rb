require_relative 'player.rb'

class Breaker < Player
  attr_reader :name, :current_guess, :board
  # attr_accessor :board

  def initialize
    super
    @name = "Code Breaker"
    @guess = []
  end

  def guess

    @current_guess = get_input
    add_feedback_to_board(@current_guess)
  end
end

# def test
#   newboard = Array.new(2){Array.new(4)}
#   p newboard
#   input = %w[r b g y]
#   newboard[newboard.find_index(Array.new(4))] = input
#   p newboard
# end
#
# test
