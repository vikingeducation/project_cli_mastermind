class TowersOfHanoi
	def initialize(tower_height=3)
		@towers = Towers.new(tower_height)


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
	def initialize(tower_height)
		@towers = Array.new(2) { Array.new(tower_height, 0) }
		first_tower = (1..tower_height).to_a.reverse
		@towers.unshift(first_tower)
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


t = TowersOfHanoi.new
















