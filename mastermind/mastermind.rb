# Pull in board, codebreaker, and codemaker classes
require_relative 'board'
require_relative 'codebreaker'
require_relative 'codemaker'

# Pull in deep dup module
require_relative 'deep_dup'

class Mastermind

  # TODO:  Convert to options hash
  def initialize(max_guesses = 3, player_name = 'Ruby Tuby', allow_dups = false)
    @max_guesses = max_guesses
    @board = Board.new
    @codemaker = Codemaker.new(allow_dups, @board)
    @codebreaker = Codebreaker.new(player_name, @board)

    @current_player = @codebreaker

    start
  end

  private

  def start
    puts "************************************"
    puts "***    Welcome to Mastermind!    ***"
    puts "************************************\n\n"
    puts "INSTRUCTIONS:"
    puts "Enter your color guess using letters separated by a comma.\n\n"
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
    # TODO: check for win or quit
    victory? || out_of_guesses?
  end

  # TODO: allow for quitting
  def quit
  end

  def out_of_guesses?
    if @board.guesses.size >= @max_guesses
      puts "Sorry, you ran out of guesses. Better luck next time!"
      true
    else
      false
    end
  end

  def victory?
    if @board.winning_guess?
      puts "Congrats!!  You WIN!!"
      true
    else
      false
    end
  end

end

game = Mastermind.new