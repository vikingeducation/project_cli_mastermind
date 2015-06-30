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
    @code_maker = CodeMaker.new(@board)
		# set up codebreaker
    @code_breaker = CodeBreaker.new(@board)
  end

	# play
  def play

    @code_maker.get_code
		# loop indefinitely
    loop do
			# call board rendering method
      @board.render
			# ask for guess from codebreaker
      @code_breaker.get_guess


			# break the loop IF game is over
      break if check_game_over
    end

    puts "Game over."
  end

	def check_game_over
		@code_breaker.guess_count > 12 || @board.check_victory?
  end

end

# Manages all board functionality
class Board

	def initialize
		@board = []
  end

	def render
		@board.each do |guess|
      print guess
      print "\n"
    end
  end

  def add_guess(guess)
    @board << guess
  end

  def get_code(code)
    @code = code
  end

  def show_code
    @code.each {|c| print c+" "}
  end

  def check_victory?
    @board[-1] == @code
  end

  # check_correct_guesses

  # check_correct_places

end

class CodeBreaker
  PEG_COLORS = %w( b g o r p y)
  attr_reader :guess_count

  def initialize(board)
    @guess_count = 0
    @board = board
  end

  def get_guess
    loop do
      guess = ask_for_guess
      if is_valid_guess?(guess)
        @board.add_guess(guess)
        add_guess_count
        break
      end
    end
  end

  def ask_for_guess
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
  end

  def add_guess_count
    @guess_count += 1
  end

end

class CodeMaker
  PEG_COLORS = %w( b g o r p y)

  def initialize(board)
    @board = board
  end

  # get_codes
  def get_code
    loop do
      code = ask_for_code
      if is_valid_code?(code)
        @board.get_code(code)
        break
      end
    end
  end

  def ask_for_code
    p "Enter code >> "
    code = gets.chomp.split("")
  end

  def is_valid_code?(code)
    code.each do |p|
      unless PEG_COLORS.include?(p)
        p "#{p} is not a valid color."
        return false
      end
      return true
    end
  end

end



