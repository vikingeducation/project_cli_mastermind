# Game class
require_relative 'board'
require_relative 'breaker'
require_relative 'maker'
require_relative 'player'
require_relative 'peg'


LEGAL_COLORS = ['r','g','b','y','o','p']

class Game

  def initialize
    @board = Board.new
    @breaker = Breaker.new
    @maker = Maker.new
  end

  def play
    secret_code = Maker.get_code
    until victory?
      # Guess [Player::Human]
      @breaker.get_code until @breaker.valid_input?
      @board.add_guess(@breaker.guess, secret_code)
      @board.render
      # Feedback [Feedback]
      # Render board [Board]
      # check if Code matches secret Code [Game]
      # check if 12 attempts are up [Game]
    end
    # Display Code
    # Congratulate or try agian
  end

end






# Initialize Game [Game]
  # Initialize Board [Board]
    # Create secret code [Computer]
  # Initialize Players [Player]
