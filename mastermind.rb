require "./board.rb"
require "./player.rb"
require "./human.rb"
require "./computer.rb"

$COLORS {
  'r' => "Red",
  'b' => "Blue",
  'g' => "Green",
  'o' => "Orange",
  'y' => "Yellow",
  'w' => "White",
  'p' => "Pink",
  'v' => "Violet"
}

class Mastermind

  def initialize
    # assign codebreaker -> Player.create_player
    @codebreaker = Player.create_player("the Codebreaker")
    # assign codemaker -> Player.create_player
    @codemaker = Player.create_player("the Codemaker")
    # create new board with setup from codebreaker
    @board = Board.new(@codebreaker)
  end

  def play

    loop do 
    # render board [board]
      @board.render
    # check for game over [Board]
      break if @board.game_over?
    # allow player to guess or quit and send to Board[Player]
      @board.move(@codebreaker.get_move(@board))
    end

  end


  # end game
end
  








