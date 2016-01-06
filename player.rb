require_relative 'board.rb'

class Player

  attr_accessor :guess, :turn, :board

  def initialize
    @turn = 12
    @board = Board.new
    @guess = nil
  end




end



