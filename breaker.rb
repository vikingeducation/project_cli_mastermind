class Breaker < Player
  attr_accessor :guess_board, :name

  def initialize
    @guess_board = Board.new
    @name = "Code Breaker"
  end

  def guess
    guess = get_input
    make guess
  end
end
