Set up game initially [mastermind]
	Create game board [board]
	Create player and AI [player]
	Distinguish between Codemaker and Codebreaker [player]

	Start game loop [mastermind]
		Render the board [board]

		IF AI guesses code [mastermind]
				display appropriate message
				break loop
			ELSE
				display appropriate message
				break loop

		IF player guesses code [mastermind]
				display appropriate message
				break loop
			ELSE
				display appropriate message
				break loop


		IF player is Codemaker 
			Ask player to create a code [mastermind]
			start a loop [player]
			Have AI guess the code [player]
			validate guseses [player]
				AI has 12 turns to do so
			

		IF player is Codebreaker 
			Have AI generate a code [mastermind]
			start a loop [player]
			have player guess the code [player]
			validate player guesses [player]
				player has 12 turns to do so
			
	classes
	 MASTERMIND
	 BOARD
	 PLAYER
	 AI

	 MASTERMIND
	 	# initialize
	 		# set up game board
	 		# set up players
	 		# @maker = Player.new
	 		# @breaker = AI.new
	 		# OR
	 		# @breaker = Player.new
	 			# determine whether player is codemaker or codebreaker



	 	# play
	 		# IF player is codemaker ask player to set_code
	 		# loop while guess_count < 12
	 			# call render method
	 			# have AI guess_code 
					# IF guess_correct?
 							# break loop
 					# ELSE add_guess and continue loop

	 
	 		# ELSE player is codebreaker
	 			# generate_random_code
	 			# loop while guess_count < 12
	 				# call render method
	 				# have player guess_code
	
	 						# IF guess_correct?
	 							# display appropriate message
	 								# break loop
	 						# ELSE add_guess appropriately and continue loop

	 		# guess_correct?
	 		# IF guess = code
	 			# display victory message
	 			# true
	 		# ELSE
	 			# display try again message
	 			# compare_guess
	 			# add_guess

	 		# compare_guess
	 			# display what was right and what was wrong


	PLAYER
		#initialize 
			# set as codemaker/codebreaker
				# IF codebreaker initialize with guesses variable
				# IF codemaker initialize with 

	 	# set_code
	 		# display instructions for setting the code
	 		# get player code from command line

	 	# generate_random_code
	 		# generate a random code for player to guess

	 	# guess_code
	 		# loop infinitely
	 		# prompt player to enter guess
	 		# IF validate_guess_format
	 			# IF guess_correct?
	 				# display victory message
	 				# exit
	 			# ELSE
	 				# display guess again message
	 				# add_guess

	 	# validate_guess_format
	 		# is the guess appropriately formatted?

	 	


	 BOARD
	 	# initialize board
	 		# set up blank data structure

	 	# render the board
	 		# loop through data structure
	 		 	# display_guesses

	 	# add_guess
	 		# add to guesses

	 	# display_guesses
	 		# displays guesses appropriately


	 AI
		# initialize if player is codemaker
	 	# guess_code
	 	 # 











