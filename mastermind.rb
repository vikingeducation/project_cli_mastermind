=begin
initialize the game         Mastermind
initialize the board        Board
initialize the player       Player
make a random combination   Board

loop 12 times               Mastermind
  ask player for guess      Player
  compare to the solution   Board
    near_clue if one color match the solution Board
    right_clue if one color is well place     Board
  check victory state                         Board
end
loose, show combination                       Board

=end

require_relative "player"
require_relative "board"

class Mastermind
  attr_accessor :turn, :board

  def initialize
    @board = Board.new
    @player = Player.new
    @turn = 1
    play
  end

  def play
    instruction
    @board.random_combination
    @board.render_board

    while @turn < 13
      input = @player.get_combination
      check_save_input input

      @board.render_board
      @turn += 1

    end
    puts "you loose!"
  end

  def check_save_input input
    @board.save_in_board( input, @turn )
    @board.compare input
  end


  def instruction
    puts "hello"
    puts "guess the combination\n"
    puts "Enter Your Combination, compose of 4 numbers\n"
    puts "In between 1 and 6, like so :   2 4 1 6\n"
  end
end


game = Mastermind.new





