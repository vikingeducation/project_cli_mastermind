
require_relative "player"
require_relative "board"

class Mastermind

  def initialize
    @board = Board.new
    @player = Player.new
    @turn = 1
  end

  def turn
    @turn
  end

  def play
    instruction
    @board.render_board

    while turn < 13
      input = @player.get_combination

      analyse input

      @board.render_board
      @turn += 1

    end
  end

  def analyse input
    @board.save_in( input, turn )
    @board.compare( input, turn )
  end


  def instruction
    puts "hello"
    puts "guess the combination\n"
    puts "Enter Your Combination, compose of 4 numbers\n"
    puts "In between 1 and 6, like so :   2 4 1 6\n"
  end
end


game = Mastermind.new
game.play





