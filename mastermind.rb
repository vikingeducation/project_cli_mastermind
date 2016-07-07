# Game class
require "pry"
require_relative 'board'
require_relative 'human'
require_relative 'computer'
require_relative 'peg'


LEGAL_COLORS = ['r','g','b','y','o','p']

class Game

  def initialize
    @board = Board.new
    get_choice
    @turn = 12
    @secret_code = @maker.get_secret_code
  end

  def get_choice
    puts "Would you like to make the code or break the code?"
    choice = gets.chomp.downcase
    if choice == 'make'
      @breaker = Computer.new
      @maker = Human.new
    elsif choice == 'break'
      @breaker = Human.new
      @maker = Computer.new
    else
      puts "invalid choice, please enter 'make' or 'break'"
      get_choice
    end
  end

  def play
    until game_over?
      puts "You have #{@turn} turns left."
      @breaker.guess = []
      @breaker.get_code until @breaker.valid_input?
      @board.add_guess(@breaker.guess)
      @board.get_feedback(@breaker.guess, @secret_code)
      @board.render
      @turn -= 1
    end
  end

  def game_over?
    guessed_correctly? || out_of_turns?
  end

  def guessed_correctly?
    puts "Breaker won" if @breaker.guess == @secret_code
    @breaker.guess == @secret_code
  end

  def out_of_turns?
    puts "The Breaker lost the code was #{@secret_code}" if @turn == 0
    @turn == 0
  end
end


mm = Game.new

mm.play



# Initialize Game [Game]
  # Initialize Board [Board]
    # Create secret code [Computer]
  # Initialize Players [Player]
