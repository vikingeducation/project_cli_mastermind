
# game should have a board and pass things to board that board needs to 
# run

# store an instance of Board in Game somewhere (initialize method?)

# expand feedback into multiple method calls and move it to game

# make more methods accept parameters

require_relative 'game'

class Board

  attr_accessor :answer

  def initialize
    @answer = generate_code
  end

  def generate_code
    code = []
    code = 4.times {code << COLORS.sample}
    code
  end

end
