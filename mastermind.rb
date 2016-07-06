# Game class
require "pry"

require_relative 'board'
require_relative 'breaker'
require_relative 'maker'
require_relative 'peg'


LEGAL_COLORS = ['r','g','b','y','o','p']

class Game

  def initialize
    @board = Board.new
    @breaker = Breaker.new
    @maker = Maker.new
    @turn = 0
    @secret_code = @maker.get_code
  end

  def play
    

    until game_over?
      @breaker.guess = []
      @breaker.get_code until @breaker.valid_input?

      @board.add_guess(@breaker.guess)
      @board.get_feedback(@breaker.guess, @secret_code)
      @board.render
      # Feedback [Feedback]
      # Render board [Board]
      # check if Code matches secret Code [Game]
      # check if 12 attempts are up [Game]
      @turn += 1
    end
    # Display Code
    # Congratulate or try agian
  end

  def game_over?
    guessed_correctly? || out_of_turns?
  end

  def guessed_correctly?
    puts "Congrats, you won!" if @breaker.guess == @secret_code
    @breaker.guess == @secret_code
  end

  def out_of_turns?
    puts "Sorry, you lost" if @turn > 12
    @turn > 12
  end
end


mm = Game.new

mm.play



# Initialize Game [Game]
  # Initialize Board [Board]
    # Create secret code [Computer]
  # Initialize Players [Player]
