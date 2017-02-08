class Mastermind
  CODE_COLORS = [:red, :blue, :yellow, :green, :orange, :purple]
  FEEDBACK_COLORS = [:black, :white]

  def initialize(turns = 12)
    @code = nil
    @turns = turns
    @current_turn = 1
    @board = Board.new
    @player = Player.new
  end

  # main game loop
  def play
  end

  private

  # checks if the player made a correct guess
  def player_won?
  end

  # gives feedback on the player's guess
  def give_feedback(guess)
  end

  # prints instructions/rules for game,
  # e.g. valid input format for guess, how to quit
  def display_instructions
  end
end

class Board
  def initialize
    board = {}
    feedback = {}
  end

  # print out current game board with feedback
  def display_board
  end

  # update the game board with the latest move
  def update_board(turn, move)
  end

  # update the game board with feedback on the latest move
  def update_feedback(turn, move)
  end
end

class Player
  attr_reader :guess

  def initialize
    @guess = nil
  end

  # prompts the user for his next guess
  def make_guess
    loop do
      print "Please enter your guess: "
      guess = gets.chomp
      formatted_guess = format_guess(guess)
      if valid_guess?(formatted_guess, Mastermind::CODE_COLORS)
        @guess = formatted_guess
        break
      else
        puts "That guess is invalid. Please try again."
      end
    end
  end

  private

  # formats player guess into an expected format
  def format_guess(guess)
    guess.split(/\W+/).map { |color| color.downcase.to_sym }
  end

  # checks if the player's guess is valid
  def valid_guess?(guess, code_colors)
    guess.length == 4 && guess.all? { |color| code_colors.include?(color)}
  end
end
