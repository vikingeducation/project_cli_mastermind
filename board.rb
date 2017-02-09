class Board
  def initialize
    @board = {}
    @feedback = {}
  end

  # print out current game board with feedback
  def display_gameboard(current_turn)
    puts
    1.upto(current_turn) do |turn|
      puts "Turn: #{turn} | Guess: #{process_guess(board[turn])} | Feedback: #{process_feedback(feedback[turn])}"
    end
    puts
  end

  # update the game board with the latest guess
  def update_board(turn, guess)
    board[turn] = guess
  end

  # update the game board with feedback on the latest guess
  def update_feedback(turn, feedback)
    self.feedback[turn] = feedback
  end

  # converts guess into a string
  def process_guess(guess)
    guess.map(&:to_s).join(", ")
  end

  # converts feedback into a string
  def process_feedback(feedback)
    unless feedback.empty?
      feedback.values.join(", ")
    else
      return "No matches"
    end
  end

  # protected accessor methods
  protected

  def board
    @board
  end

  def feedback
    @feedback
  end
end