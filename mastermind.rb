# Game class
class Game

  def initialize
    @board = Board.new
    @breaker = Human.new
    @maker = Computer.new
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

# Maker class
# Board class
# Code class
class Code

  def initialize
    @row = []
  end

  def get_code
    puts "What is your guess?"
    response = gets.chomp.split('').map { |color| color.color_to_i }
  end

end
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
