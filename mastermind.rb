=begin
12 guesses
guess 4 pegs

after guessing we're shown information via black/white pegs



Input
  - players = []
  - Current player
  - Takes guesses until valid depending on player

Player
  @score = 0
  def play
    raise NotImplemented
  end
end

Human < Player

end

AI < Player

end

# draws visual representation of game
Renderer

# Runs game loop
Game

  def play
    get input
    update board internal state
    see if lost
      (award points)
    redraw
  end
=end

# Board
#   - Represents game
#   - Holds winning combination
#   - Accepts guesses from input
#   - Calculates hints
#   - Updates state
#     - Adding array to @guesses

class Board

  def initialize(condition = [])
    @guesses = []
    @hints = []
    @winning_condition = condition
  end

  def set_win_condition(condition)
    @winning_condition = condition
  end

  def num_guesses
    @guesses.length
  end

  def accept_guess(guess)
    new_hint = calculate_hint(guess)
    @guesses << guess
    @hints << new_hint
  end

  def calculate_hint(guess)
    black_pegs, white_pegs = count_pegs(guess)
    
    generate_hint(black_pegs, white_pegs)
  end

  def generate_hint(black, white)
    hint = []

    black.times {hint << "B"}
    white.times {hint << "W"}

    hint << " " until hint.length > 3
  end

  def count_pegs(guess)
    black_pegs = 0
    white_pegs = 0

    guess.each_with_index do |val, index|
      if val == @winning_condition[index]
        black_pegs += 1
      elsif @winning_condition.include? val
        white_pegs += 1
      end
    end
    return black_pegs, white_pegs
  end


  def check_win?
    @guesses[-1] == @winning_condition
  end

end

# Input
#   - players = []
#   - Current player
#   - Takes guesses until valid depending on player

class Input 

  def get_guess
    guess_input = gets.chomp.upcase
    valid_guess?(guess_input)

  end

  def valid_guess?(guess)
    guess.split(" ").any? { |char| !(["B", "G", "R", "O", "Y", "P" ].include?(char)) }

  end

end








