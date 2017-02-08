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

  # checks if the player made a correct guess
  def player_won?
    player.guess == code
  end

  # gives feedback on the player's guess
  def give_feedback(guess)
  end

  # prints instructions/rules for game,
  # e.g. valid input format for guess, how to quit
  def display_instructions
    puts "Welcome to Mastermind!"
    puts "You have #{turns} turns to guess a code consisting of 4 colored pegs."
    puts "Each peg can be any of the following colors: #{CODE_COLORS.map(&:to_s).join(", ")}."
    puts "If your guess is incorrect, you will get feedback in the form of black and white pegs."
    puts "A black peg indicates your guess includes a peg which is correct in both color and position."
    puts "A white peg indicates your guess includes a peg which is correct in color, but in the wrong position."
    puts "Good luck!"
  end

  protected

  def turns
    @turns
  end
end

class Board
  def initialize
    @board = {}
    @feedback = {}
  end

  # print out current game board with feedback
  def display_board(turn)
    puts "Turn: #{turn} | Guess: #{board[turn]} | Feedback: #{feedback[turn]}"
  end

  # update the game board with the latest move
  def update_board(turn, move)
    board[turn] = move
  end

  # update the game board with feedback on the latest move
  def update_feedback(turn, feedback)
    self.feedback[turn] = feedback
  end

  # protected accessor methods
  protected

  def board
    @board
  end

  def feedback
    @feedback
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

m = Mastermind.new
m.display_instructions