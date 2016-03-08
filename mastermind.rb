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

class Mastermind
  def initialize
    @board = Board.new
    @player = Player.new
    play
  end

  def play
    @board.random_combination
    @board.create_board
    instruction
    @board.render
  end

  def instruction
    puts "hello"
    puts "guess the combination\n"
  end
end


class Board
  def initialize
    @combination = {}
    @board = {}
  end

  def random_combination
    combination = {}
    (1..4).each do |i|
      combination[i] = rand(1..6)
    end
    combination
  end

  def create_board
    (1..12).each { |row| @board[row] = {1 => 0, 2 => 0, 3 => 0, 4 => 0} }
  end

  def render_board
    4.downto(1) do |row|
      @board.each do |k, v|
        if k >= 10
          print v[row].to_s + "   "
        else
          print v[row].to_s + "  "
        end
      end
      print "  *\n"
    end
    @board.keys.each { |key| print key.to_s + "  "}
    print "  C\n"
  end
end


class Player
  def enter_input
  end
    
end

a = Mastermind.new






