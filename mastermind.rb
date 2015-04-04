# Controls the overall game
class Mastermind
	# Setup initial instance variables
	def initialize
		# Create a new board
		@board = Board.new

		# Create a new codebreaker
		@codebreaker = Codebreaker.new

		# Create a new codemaker
		@codemaker = Codemaker.new

		# Get code for the game from the codemaker
		@master_code = Codemaker.new.create_code

		# Start the game up
		start
	end
	
	# Ask if user wants to be codemaker or codebreaker?
	def start
		error_message = nil
		loop do
			@board.render
			puts error_message || "Enter 1 for codemaker, 2 for codebreaker:"
			input = gets.chomp.to_i
			if input == 1
				self.play_codemaker
				break
			elsif input == 2
				self.play_codebreaker
				break
			else
				error_message = "Invalid input, please try again"
				redo
			end
		end
	end

	def play_codemaker
		# Set the ending type as a loss by default
		ending_type = "loss"

		# Ask the codemaker to set the code
		@master_code = @codemaker.set_code
		
		# Start the loop 12 times
		12.times do
			# Render board
			@board.render

			# Get guess
			@guess = []
			4.times do
				@guess << (rand * 6).ceil
			end

			# Guess needs to be a string
			@guess = @guess.join(' ')

			# Add guess to output
			@board.add_output(@guess + " | ")

			# Test the guess
			if check_guess(@guess)
				ending_type = "victory"
				break
			end
		end

		# End the game and send the ending type
		@board.end_game(ending_type, @master_code)
	end

	# Play Mastermind as codebreaker!!
	def play_codebreaker
		# Set the ending type as a loss by default
		ending_type = "loss"

		# Start the game loop 12 times
		12.times do
			# Render board
			@board.render

			# Ask the codebreaker for their guess
			@guess = @codebreaker.guess

			# Add the guess to the output
			@board.add_output(@guess + " | ") 

			# Test the guess
			if check_guess(@guess)
				ending_type = "victory"
				break
			end
		end

		# End the game and send the ending type
		@board.end_game(ending_type, @master_code)	
	end

	# Check the codebreaker's guess
	def check_guess(guess)
		# Get the helper info for every guess
		get_helpers(guess)

		# True if the guess = the master code
		true if guess.split(' ').map(&:to_i) == @master_code
	end


	# Get helpers
	def get_helpers(guess)
		# Setup helper variables. I want to 
		# set these up because I will be destroying
		# these variables to get the helpers.
		temp_guess, temp_master, exact_match = guess.split(' ').map(&:to_i), @master_code.dup, []

		# Any exact matches
		temp_master.each_with_index do |master_code_input, index|
			if master_code_input == temp_guess[index]
				@board.add_output("X")
				temp_master[index] = nil
				temp_guess[index] = nil
			end
		end

		# Any color matches (not position)?
		temp_master.each_with_index do |master_code_element, master_code_index|
			unless master_code_element.nil?
				if temp_guess.include?(master_code_element)
					temp_guess[temp_guess.find_index(master_code_element)] = nil
					temp_master[master_code_index] = nil
					@board.add_output("O")
				end
			end
		end

		# Add newline to the end
		@board.add_output("\n")
	end
						
end

# Controls features of the codebreaker
class Codebreaker
	# Ask user for their guess
	def guess
		# Keep guessing until it's in the proper format
		error_message = nil
		loop do
			puts error_message || "Enter guess:"
			guess = gets.chomp.split(',').map(&:to_i)
			if valid_input?(guess)
				# If we have a valid guess then return it as a string
				return guess.join(' ')
				break
			else
				error_message = "Invalid input, try again"
			end
		end
	end

	# Is the input valid?
	def valid_input?(guess)
		# Is input length 4?
		if guess.length == 4
			# Is each item a number
			if guess.all? { |element| element.class == Fixnum && 1 <= element && element <= 6 }
				true
			else
				false
			end
		else
			false
		end
	end
end

# Controls the features of the codemaker
class Codemaker
	# Create new random master code
	def create_code
		code = []
		4.times do 
			code << (rand * 6).ceil
		end
		code
	end

	# Prompt user to enter code
	def set_code
		@codebreaker = Codebreaker.new
		error_message = nil
		loop do
			puts error_message || "Please enter your four-digit code.\nAccepts #'s 1-6 as input, comma separated\nExample: 1,2,3,4\n"
			input = gets.chomp.split(',').map(&:to_i)
			if @codebreaker.valid_input?(input)
				return input
				break
			else
				error_message = "Invalid input. Please enter code again."
				redo
			end
		end
	end
end

# Creates and holds features for the board
class Board
	# Initialize the board
	def initialize
		@output = 
"                  MASTERMIND\n
-------------------------------------------
You have 12 turns to guess the secret code!
Enter in the format of _,_,_,_
Helpers will appear to the right of your guess.
X indicates a guess is the 
right number AND position.
O indicates a guess is the 
right number but in the wrong position.
Good luck!
-------------------------------------------\n\n"
	end

	# Render board method
	def render
		self.clear
		print @output
	end

	# Add to the output
	def add_output(input)
		@output << input
	end

	# Clear the board
	def clear
		system "clear"
	end

	# End the game
	def end_game(ending_type, master_code)
		if ending_type == "victory"
			@output << "Congratulations!! You broke the code!\n"
		else
			@output << "Sorry, you lost. The code was #{master_code}\n"
		end
		self.render
	end

end

a = Mastermind.new