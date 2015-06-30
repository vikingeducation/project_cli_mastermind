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
      sort_guess = guess.sort
      sorted_win_condition = @winning_condition.sort

      guess.each_with_index do |val, index|
        if val == @winning_condition[index]
          black_pegs += 1
        end
      end

      sort_guess.each_with_index do |val, index|
        if val == sorted_win_condition[index]
          white_pegs += 1
        end
      end

      white_pegs = white_pegs - black_pegs

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

  attr_reader :player_num

  def initialize(player_num)
    @score = 0
    @is_breaker = false
    @player_num = player_num
  end

  def is_breaker?
    @is_breaker
  end

  def set_role(val = true)
    @is_breaker = val
  end

  def play
    raise NotImplemented
  end
end

class Human < Player

  def play
    @is_breaker? code_breaker : code_maker
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

end

class AI < Player

  def play
    @is_breaker? code_breaker : code_maker
  end

  def code_breaker
    choice = []

    puts "The computer is selecting a move!"
    4.times do
      choice << COLORS.sample
    end

    sleep 1

    choice
  end


  def code_maker
    choice = []

    puts "The computer is making a code!"

    4.times do
      choice << COLORS.sample
    end

    sleep 2

    choice
  end

end

class Renderer

  def initialize(board)
    @guesses = board.guesses
    @hints = board.hints
  end

  def draw
    puts (" " * 16) + "The  Board"
    puts (" " * 7) + ("Choice") + (" " * 17) + ("Hint")
    @guesses.length.times do |val|
      puts "#{@guesses[val]}  #{@hints[val]}"
      # print "Hints: "
      # p @hints[val]
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

#switch players if won or turns  = 12 
#   end

class Game
  def initialize
    @board = Board.new
    #@input = Input.new
    @renderer = Renderer.new(@board)
    @player1 = Human.new(1)
    @player2 = AI.new("COMPUTER")
    @players = [@player1, @player2]
  end

  def play

    start_play
    get_win_condition
    play_round

  end

  private

    def play_round
      until(game_won || game_lost)
        # Get a guess from the breaker player
        new_guess = breaker.play
        @board.accept_guess(new_guess)
        check_breaker_win
        @renderer.draw
      end
    end

    def game_lost
      if @board.num_guesses > 11
        puts "Player #{breaker.player_num} lost!"
        return true
      end
    end

    def game_won
      if @game_won
        puts "Player #{breaker.player_num} won!"
      end
    end

    # Handles finding if the player won or not
    def check_breaker_win
      if @board.check_win?
        @game_won = true
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
      new_code = maker.play

      @board.set_win_condition(new_code)
    end

    def breaker
      @players.select{|player| player.is_breaker?}[0]
    end

    def maker
      @players.reject{|player| player.is_breaker?}[0]
    end
end

game = Game.new

game.play