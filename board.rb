class Board

  COLORS = ["RED", "ORANGE", "YELLOW", "GREEN", "BLUE", "PURPLE"]  
  
  attr_accessor :pegs
  
  def initialize
    @pegs = 4
  end



  def render(guess_array)
    guess_array.each do |row|
      print row
    end
  end

end

guess_array = [["Red", "Orange", "Yellow", "Green"]]

# b = Board.new
# b.render(guess_array)