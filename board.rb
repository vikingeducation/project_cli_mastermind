require_relative 'logic.rb'

class Board

  COLORS = ["RED", "ORANGE", "YELLOW", "GREEN", "BLUE", "PURPLE"]  
  
  attr_accessor :pegs
  
  def initialize
    @pegs = 4
    @logic = Logic.new
  end


  def render_logic(winning_board, guess_board)
    colors = @logic.evaluate_color(winning_board, guess_board)
    position = @logic.evaluate_position(winning_board, guess_board)
    "correct colors: #{colors}, correct positions: #{position}"
  end


  def render(previous_guesses, winning_board, guess_board)
    previous_guesses.each do |row|
      print "Previous guesses:"
      print "\n#{row}  #{render_logic(winning_board, guess_board)}\n"
    end
  end

end

guess_array = [["Red", "Orange", "Yellow", "Green"]]

# b = Board.new
# b.render(guess_array)