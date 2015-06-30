=begin
Set up game initiallly (Mastermind)
  create game board (Board)
  create CodeMaker (CodeMaker)
  create CodeBreaker (CodeBreaker)
  create code (CodeMaker)

start game loop (Mastermind)
  reader game board (Board)
  ask for and validate player's guess (CodeBreaker)
  If the game should end (Mastermind)
    Display the proper message
    stop looping
  else
    add to guess_count (CodeBreaker)
    keep looping (Mastermind)
=end



class Mastermind

	# initialize
  def initialize
		# set up the board
    @board = Board.new
		# set up codemaker
    @code_maker = CodeMaker.new
		# set up codebreaker
    @code_breaker = CodeBreaker.new
  end

	# play
  def play

		# loop indefinitely
    loop do
			# call board rendering method
      @board.render
			# ask for guess from codebreaker
      guess = @code_breaker.get_guess


			# break the loop IF game is over
      break if check_game_over
    end

	def check_game_over
		check_victory
  end

	def check_victory
    @code_breaker.guess_count > 12 || @code_breaker.get_guess == @code_maker.code
  end

end

# Manages all board functionality
class Board
  PEG_COLORS = %w( b g o r p y)

	def initialize
		@board = []
  end

	def render
		@board.each do |guess|
      puts guess
    end
  end

  def add_guess(guess)
    @board << guess
  end

  def get_code(code)
    @code = code
  end

  def check_victory?(guess)
    guess == @code
  end

  # check_correct_guesses

  # check_correct_places

end

class CodeBreaker
  PEG_COLORS = %w( b g o r p y)

  # initialize
    @guess_count = 0

  def get_guess
    p "Enter guess >> "
    guess = gets.chomp.split("")
  end

  def is_valid_guess?(guess)
    guess.each do |p|
      unless PEG_COLORS.include?(p)
        p "#{p} is not a valid color."
        return false
      end
      return true
  end

  def add_guess_count
    @guess_count += 1
  end

end

class CodeMaker

  # get_codes

  # is_valid_codes?

end



