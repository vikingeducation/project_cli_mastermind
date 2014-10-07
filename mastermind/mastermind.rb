# Mastermind


# ------------ MasterMind -----------------------------------------------------


class MasterMind

	def initialize(game_type)
		# sets up board
		@board = Board.new
		@code = []
		@turn_count = 0
		@game_type = game_type

		# sets up the codemaker/codebreaker
		if game_type == 1
			@maker = Player.new(1, nil, @code)
			@breaker = AI.new(@turn_count, @board)
		else
			@breaker = Player.new(2, @board, nil)
		end

	def play
		if @game_type == 1

			@maker.set_code
			
			while @turn_count < 12
				@board.render
				@breaker.guess_code
				break if guess_correct?
			end

		else
			
			generate_random_code
			
			while @turn_count < 12
				@board.render
				@breaker.guess_code
				break if guess_correct?
			end
		end

	end

	def generate_random_code
		@code = Array.new(4) { ('A'..'F').to_a.sample }
	end

	def guess_correct?

		if @board.guesses.last == @code
			puts "You guessed the code. You win!"
			true
		else
			compare_guess
			puts "Message that says how close you were"
			add_guess
		end
	end

	def compare_guess

	end

end


# ------------ Player ---------------------------------------------------------

class Player

	def initialize(player_type, board=nil, code=nil)
				@board  ||= nil
				@code 	||=	nil
	end


	def set_code
		puts "Create a secret code for the AI to guess. Choose 4 letters from A-F (i.e. ABCD or FEAD)"
		@code = gets.strip.upcase.split('')
	end


	def guess_code
		loop do
			puts "Take a stab at the code. Choose four letters from A-F (i.e. BDCE or DEAF)"
			guess = gets.chomp.strip.split('')
			@board.add_guess(guess)
			if guess_correct?
				break

				# ^^ START HERE
		end

	end 


	


end


# ------------ Board ----------------------------------------------------------

class Board

	def initialize
		@guesses = []
	end


	def render
		@guesses.each do |guess_array|
			puts guess_array
		end
	end

	def add_guess(guess)
		if validate_guess_format(guess)
			@guesses << guess
		end
	end

	# def display_guesses <-- used to render once you're at that point

	# end

	def validate_guess_format(guess)
		if guess.is_a?(Array) && guess.size == 4
			true
		else
			puts "Your guess is in the improper format."
		end
	end


end

# ------------ AI -------------------------------------------------------------

class AI 

def guess_code

end



end





