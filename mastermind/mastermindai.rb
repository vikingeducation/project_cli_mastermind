require './board'

class MastermindAI
  def initialize(board)
    @board = board
    @guess_history = @board.guess_history
    @feedback = @board.feedback
  end

  def ai_guess
    return (1..4).map { ('a'..'f').to_a[rand(6)] }
  end
end