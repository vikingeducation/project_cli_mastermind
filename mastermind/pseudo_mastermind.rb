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
			