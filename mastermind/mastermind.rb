# Pull in deep dup and valid entry modules
require_relative 'deep_dup'
require_relative 'dataio'

# Pull in board, codebreaker, and codemaker classes
require_relative 'board'
require_relative 'codebreaker'
require_relative 'codemaker'
require_relative 'codemaker_human'
require_relative 'codebreaker_computer'

class Mastermind

  def initialize(options = {max_guesses: 3, allow_dups: false})
    @max_guesses = options[:max_guesses]
    @allow_dups = options[:allow_dups]
    @board = Board.new

    get_mode
  end

  private

  def get_mode
    puts "************************************"
    puts "***    Welcome to Mastermind!    ***"
    puts "************************************\n\n"

    puts "Enter 1 to play as the codebreaker or 2 to play as the codemaker"
    mode = gets.chomp.to_i

    if mode == 1
      puts "What is your name?"
      name = gets.chomp
      @codemaker = Codemaker.new(@allow_dups, @board)
      @codebreaker = Codebreaker.new(name, @board)
    elsif mode == 2
      @codemaker = CodemakerHuman.new(@allow_dups, @board)
      @codebreaker = CodebreakerComputer.new("Computer Guesser", @board)
    end

    start
  end

  def start
    puts "INSTRUCTIONS:"
    puts "Enter your guess/feedback using letters/characters separated by a comma.\n\n"
    puts "COLOR CODE:"
    puts "r = red, b = blue, g = green, y = yellow, p = purple, o = orange\n\n"
    puts "FEEDBACK CODE:"
    puts "* = colored peg, + = white peg\n\n"
    puts "For example:\n Enter move > r,b,g,y\n\n"

    # kick off the moves
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
      puts "Sorry, #{@codebreaker.name} ran out of guesses. Better luck next time!"
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

end

game = Mastermind.new({max_guesses: 3})