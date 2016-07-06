# Game class
class Game

  def initialize
    @board = Board.new
    @breaker = Breaker.new
    @maker = Maker.new
  end

  def play
    secret_code = Maker.get_code
    until victory?
      # Guess [Player::Human]
      @breaker.get_code until @breaker.valid_input?
      @board.add_guess(@breaker.guess)
      # Feedback [Feedback]
      # Render board [Board]
      # check if Code matches secret Code [Game]
      # check if 12 attempts are up [Game]
    end
    # Display Code
    # Congratulate or try agian
  end

end
# Player class
class Player
  attr_reader :guess

  def initialize
    @guess = []
  end

  def get_code
    puts "What is your guess?"
    @guess = gets.chomp.split(' ').map { |color| Peg.new(color) }
  end

  def valid_input?
    correct_length? &&
    correct_colors?
  end

  def correct_length?
    @guess.length == 4
  end

  def correct_colors?
    @guess.all? { |peg| peg.color_num }
  end

end
# Human
class Breaker < Player
  attr_reader :guess

  def initialize

  end

end

class Maker < Player
  def initialize
  end

  def get_code
  end

end

# Maker class
# Board class
class Board

  def initialize
    @board = []
  end

  def render
  end

  def add_guess(guess)
    @board << guess
    get_feedback
  end

end
# Code class
class Code

  attr_reader :code

  def initialize
    @code = []
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
  attr_reader :color_num
  $COLOR_TO_NUM = { r:1, g:2, b:3, y:4, o:5, p:6 }

  def initialize(color)
    @color_num = $COLOR_TO_NUM[color.to_sym]
  end
end

class Feedback
  def initialize(code)
    @code = code
  end

  def close_color_count
    @code.each do
    end
  end

  def exact_color_count
  end

end

# Initialize Game [Game]
  # Initialize Board [Board]
    # Create secret code [Computer]
  # Initialize Players [Player]
