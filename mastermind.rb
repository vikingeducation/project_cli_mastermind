class Game
  def initialize(attrs)
    @turns = 12
    @code_maker = attrs[:code_maker] || CodeMaker.new
  end

  def play
    welcome
    @code_maker.generate_secret_code
  end

  def welcome
    puts "Welcome to Mastermind!"
  end
# - turn
# - win conditions
end

class Board
# - render (module?)
# - builds rows
end

# Class Row
# - compare (module?)
# * Class SecretCode (built by codemaker)
# * Class GuessRow (built by breaker)
# * Class BoardRow (what gets displayed, held in board)

# Class Peg
# - color
# - position

# Class CodeBreaker
# - guess

class CodeMaker
  COLORS = ["Red", "Grn", "Blu", "Yel", "Brn", "Ong", "Blk", "Wht"]
  def generate_secret_code
    4.times { @secret_code << COLORS.sample }
  end
end


game = Game.new
game.play

Red Grn Blu Yel
Brn Ong Blk Wht