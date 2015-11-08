# Pull in board, codebreaker, and codemaker classes
require_relative 'board'
require_relative 'codebreaker'

class Mastermind

  def initialize(max_guesses = 3, player_name = 'Ruby Tuby', allow_dups = false)
    @board = Board.new(max_guesses)
    # @codemaker = Codemaker.new(allow_dups, @board)
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
    puts "For example:\n Enter move > r,b,g,y\n\nEnter 'q' to quit. \n\nCurrent Board:"

    # kick off the moves
    play
  end

  def play
    @board.render
    @codebreaker.get_guess
  end

  def game_over?
  end

  # TODO: allow for quitting
  def quit
  end

  def switch_player
  end
end

game = Mastermind.new