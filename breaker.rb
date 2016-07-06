require_relative 'player.rb'

class Breaker #< Player
  attr_accessor :guess_board, :name

  def initialize
    @guess_board = Board.new
    @name = "Code Breaker"
  end

  def guess
    input = get_code_input
    @guess_board[@guess_board.find_index(Array.new(4))] = input
  end
end

def test
  newboard = Array.new(2){Array.new(4)}
  puts newboard
  input = %w[r b g y]
  newboard[newboard.find_index(Array.new(4))] = input
  puts newboard
end
