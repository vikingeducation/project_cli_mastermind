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
		# set up the board
		# set up codemaker
		# set up codebreaker

	# play
		# get code from codemaker

		# loop indefinitely
			# call board rendering method
			# ask for guess from codebreaker
			# add guess to codebreakerr guess count
			# break the loop IF game is over

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

	# initialize
		# create empty board

	# render
		# 

end