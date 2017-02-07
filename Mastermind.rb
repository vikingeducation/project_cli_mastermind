class Mastermind
  CODE_COLORS = [:red, :blue, :yellow, :green, :orange, :purple]
  FEEDBACK_COLORS = [:black, :white]

  def initialize(turns = 12)
    @code = nil
    @turns = turns
    @current_turn = 1
    @board = Board.new
    @player = Player.new
  end

  # main game loop
  def play
  end

  private

  # checks if the guess entered by the player is valid
  def valid_guess?
  end

  # checks if the player made a correct guess
  def player_won?
  end

  # gives feedback on the player's guess
  def give_feedback(guess)
  end
end

class Board
  def initialize
    board = {}
    feedback = {}
  end

  # print out current game board with feedback
  def display_board
  end

  def update_board(turn, move)
  end

  def update_feedback(turn, move)
  end
end

class Player
  attr_reader :guess

  def initialize
    @guess = nil
  end

  # prompts the user for his next guess
  def make_guess
  end
end
