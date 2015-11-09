# Pull in deep dup and valid entry modules
require_relative 'deep_dup'
require_relative 'dataio'

# Pull in board, codebreaker, and codemaker classes
require_relative 'board'
require_relative 'codebreaker'
require_relative 'codemaker'
require_relative 'codemaker_human'
require_relative 'codebreaker_computer'

require 'pry'

class Mastermind

  def initialize(options = {max_guesses: 3})
    @max_guesses = options[:max_guesses]
    @board = Board.new

    get_mode
  end

  private

  def get_mode
    welcome_message

    puts "Enter 1 to play as the codebreaker or 2 to play as the codemaker."
    mode = gets.chomp.to_i

    initialize_players(mode)
    start
  end

  def initialize_players mode
    if mode == 1
      puts "What is your name?"
      name = gets.chomp
      @codemaker = Codemaker.new(@board)
      @codebreaker = Codebreaker.new(name, @board)
    elsif mode == 2
      @codemaker = CodemakerHuman.new(@board)
      @codebreaker = CodebreakerComputer.new("Computer Guesser", @board)
    end
  end

  def start
    give_instructions
    play
  end

  def play
    loop do
      @codebreaker.get_guess
      @codemaker.get_feedback
      @board.render

      break if game_over?
    end
  end

  def game_over?
    # TODO: check for quit
    victory? || out_of_guesses?
  end

  # TODO: allow for quitting
  def quit
  end

  def out_of_guesses?
    if @board.guesses.size >= @max_guesses
      puts "Sorry, #{@codebreaker.name} ran out of guesses. The code was #{@codemaker.code.join(', ')}. Better luck next time!"
      true
    else
      false
    end
  end

  def victory?
    if @board.winning_guess?
      puts "Congrats!!  #{@codebreaker.name.upcase} WINS!!"
      true
    else
      false
    end
  end

  def welcome_message
    puts "************************************"
    puts "***    Welcome to Mastermind!    ***"
    puts "************************************\n\n"
  end

  def give_instructions
    puts "INSTRUCTIONS:"
    puts "Enter your guess/feedback using letters/characters separated by a comma.\n\n"
    puts "COLOR CODE:"
    puts "r = red, b = blue, g = green, y = yellow, p = purple, o = orange\n\n"
    puts "FEEDBACK CODE:"
    puts "* = colored peg, + = white peg\n\n"
    puts "For example:\n Enter move > r,b,g,y\n\n"
  end

end

game = Mastermind.new({max_guesses: 12})