# Game class
class Game

  def initialize
    @board = Board.new
    @breaker = Breaker.new
    @maker = Maker.new
    @secret_code = AutoCode.get_code
  end

  def play
  end

end
# Player class
class Player

  def initialize
  end

  def get_move
  end

  def valid_input?
  end

end
# Human
class Breaker < Player

  def initialize
    @guess = Code.new
  end

end

class Maker < Player
  def
end

# Maker class
# Board class
# Code class
class Code

  attr_reader :code

  def initialize
    @code = []
  end

  def get_code
    puts "What is your guess?"
    response = gets.chomp.split(' ').map { |color| Peg.new(color) }
  end



end

class AutoCode < Code
  def initialize
    super
  end

  def get_code
    response = []
    4.times do
      response << Peg.new($COLOR_TO_NUM[keys].sample)
    end
  end

end

class Peg
  $COLOR_TO_NUM = { r:1, g:2, b:3, y:4, o:5, p:6 }

  def initialize(color)
    @color_num = COLOR_TO_PEG[color.to_sym]
  end
end

class Feedback
  def initialize(code)
    @code = code
  end

  def close_color_count
    @code.each do
  end

  def exact_color_count
  end

end


#sample input: "r g b r"
# Feedback class
# Peg class

# Initialize Game [Game]
  # Initialize Board [Board]
    # Create secret code [Computer]
  # Initialize Players [Player]
# Loop until
  # Guess [Player::Human]
  # Feedback [Feedback]
  # Render board [Board]
  # check if Code matches secret Code [Game]
  # check if 12 attempts are up [Game]
#end
# Display Code
# Congratulate or try agian
