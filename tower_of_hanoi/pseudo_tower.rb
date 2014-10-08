
class TowerOfHanoi
	# initialize
		# set up the towers
		# set up the player

	# play
		# loop infinitely
			# call the board rendering method
			# ask how the player would like to move
			# break the loop if the game is over OR if user quits

	# check_game_over
		# check_victory
		# check_player_quit

	# check_victory
		# IF board says player successfully assembled_stack && different_tower?
			# display a victory message

	# check_player_quit
		# IF player enters 'q' instead of move
			# end the game
			# break the loop

end


class Player
	# initialize
		# ask player tower height (3-5)
		# pass parameters to towers

	# get_move
		# loop inifinitely
		# ask_for_move
		# IF validate_move_format is true
			# IF piece can be moved
				# break the loop

	# ask_for_move
		# Display message asking for move
		# Pull move from command line

	# validate_move
		# UNLESS move places bigger piece on smaller piece
			# display error message

end

class Towers
	# initialize towers
		# set up blank data structure

	# render
		# loop through data structure
		 # display existing pieces and positions

	# movie_piece
		# IF move_valid?
			# move piece
		# ELSE
			# display error message

	# move_valid?
		# is piece_smaller?

	# piece_smaller?
		# UNLESS piece is smaller
			# display error message

	# tower_assembled?
		# check if pieces assembled in correct order

	# different_tower?
	 # check current_tower different than original_tower
end