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
      @code_breaker.guess
			# add guess to codebreakerr guess count

			# break the loop IF game is over
      break if check_game_over
    end

		# display winner

	# check_game_over
		# check_victory

	# check_victory
		# IF codebreaker guess == code
			# display victory message
		# IF codebreaker guesses > 12
			# display defeat message

end

# Manages all board functionality
class Board
  PEG_COLORS = %w( b g o r p y)

	# initialize
		# create empty board

	# render
		# display codebreaker's guess and keys and guess count

  # add_guess

  # is_valid_guess?

  # check_victory

  # check_correct_guesses

  # check_correct_places

end

class CodeBreaker

  # initialize
    @guess_count = 0

  # guess

  # is_valid_guess?

end

class CodeMaker

  # get_codes

  # is_valid_codes?

end



