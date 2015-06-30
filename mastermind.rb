=begin
12 guesses
guess 4 pegs

after guessing we're shown information via black/white pegs



Input
  - players = []
  - Current player
  - Takes guesses until valid depending on player



# draws visual representation of game
Renderer



# Board
#   - Represents game
#   - Holds winning combination
#   - Accepts guesses from input
#   - Calculates hints
#   - Updates state
#     - Adding array to @guesses

=end
class Board

  attr_reader :guesses, :hints

  def initialize(condition = [])
    @guesses = []
    @hints = []
    @winning_condition = condition
  end

  def check_win?
    @guesses[-1] == @winning_condition
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

  private

    def calculate_hint(guess)
      black_pegs, white_pegs = count_pegs(guess)

      generate_hint(black_pegs, white_pegs)
    end

    def generate_hint(black, white)
      hint = []

      black.times {hint << "B"}
      white.times {hint << "W"}

      hint << " " until hint.length > 3
      return hint
    end

    def count_pegs(guess)
      black_pegs = white_pegs = 0

      guess.each_with_index do |val, index|
        if val == @winning_condition[index]
          black_pegs += 1
        elsif @winning_condition.include? val
          white_pegs += 1
        end
      end
      return black_pegs, white_pegs
    end

end

# Input
#   - players = []
#   - Current player
#   - Takes guesses until valid depending on player
#   - Accept input for code breaker & code maker
#   - Same format? 'R B Y G'

module Input
  COLORS = ["B", "G", "R", "O", "Y", "P" ]

  def get_choice
    #puts "Input your choice! (In format 'R B Y G')"
    choice_input = gets.chomp.upcase
    unless valid_choice?(choice_input)
      until valid_choice?(choice_input)
        puts "Invalid choice, please try again!"
        choice_input = gets.chomp.upcase
      end
    end

    return choice_input.split
  end

  def valid_choice?(choice)
    choice.split(" ").all? { |char| COLORS.include?(char) }
  end

end

class Player

  include Input

  def initialize(player_num)
    @score = 0
    @is_breaker = false
    @player_num = player_num
  end

  def play
    raise NotImplemented
  end
end

class Human < Player

  def inititalize
  end

  def play
    @is_breaker? code_breaker : code_maker
  end

  def is_breaker?
    @is_breaker
  end

  def code_breaker
    puts "#{@player_num} Guess the code!"
    new_guess = get_choice
    return new_guess
  end

  def code_maker
    puts "#{@player_num} Create a code!"
    new_condition = get_choice
    return new_condition
  end

  def set_role(val = true)
    @is_breaker = val
  end

end

class AI < Player

  def code_breaker
  end


  def code_maker
  end

end

class Renderer

  def initialize(board)
    @guesses = board.guesses
    @hints = board.hints
  end

  def draw
    @guesses.length.times do |val|
      print "Guesses: "
      p @guesses[val]
      print "Hints: "
      p @hints[val]
    end
  end
end





# Runs game loop
# Game

#   def play
#     get input
#     update board internal state
#     see if lost
#       (award points)
#     redraw
#   end

class Game
  def initialize
    @board = Board.new
    #@input = Input.new
    @renderer = Renderer.new(@board)
    @player1 = Human.new(1)
    @player2 = Human.new(2)
    @players = [@player1, @player2]
  end

  def play
    start_play

    get_win_condition

    while(@board.num_guesses < 12)
      # Get a guess from the breaker player
      new_guess = @players.select{|player| player.is_breaker?}[0].play
      @board.accept_guess(new_guess)
      @board.check_win?
      @renderer.draw
    end
  end

  def start_play
    puts "Do you want to be the breaker, or the maker? Input Y to be the breaker."
    choice = gets.chomp.upcase
    if choice == "Y"
      @player1.set_role(true)
      @player2.set_role(false)
    else
      @player1.set_role(false)
      @player2.set_role(true)
    end
  end

  def get_win_condition
    new_code = @players.reject{|player| player.is_breaker?}[0].play

    @board.set_win_condition(new_code)
  end
end

game = Game.new

game.play