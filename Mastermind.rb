# Game Board is generated (GAME)
# Players are established


class Mastermind

	attr_accessor :board

	NUM_ROWS = 12
	NUM_COLS = 4
	CODE = [:B, :O, :Y, :G, :P, :R]

	def initialize( game_state = nil )
		@code_maker = []
		generate_code
		@board = game_state || default_state
		@turn = 0

	end

	def default_state

		Hash.new(0)

	end

	# New Player is generated (PLAYER)
	# code is generated
	  # R Y G O P B - possible colors




	def check_victory?( guess ) #BOARD
		if @code_maker == guess
			Board.message(%q(You Win!))
			game_reset
		end
	end


	def game_reset
		@mastermind = Mastermind.new
	end


	# else CPU displays matching pegs
	def color_match? #BOARD
		# for each player color
			# does their color === cpu?
				# => true
			# else => false
	end

	# until turn 13 - loop through game
	# player is prompted for 1st guess
	def game_loop
		# prompt player for guess
		# check guess against CPU
			# if victory - win
			# else
				# check color against position


	 	# display loss upon 13+ turn
	end

	def lose
		#you lose
	end




	def position_match?( code_breaker, code_maker) #BOARD
		# check the index of the matched colors
			# cpu.index(color) == player.index(color) ?
	end

	def check_guess( guess ) #BOARD


	end



	def place_guess_on_board ( guess )

		@board[@turn-1] = guess

	end




	def max_turn
		@turn == 12
	end

	def valid_move?( guess )
		count = 0

		guess.each do |x|
			count += 1 if CODE.include?(x)
		end

		if count == 4
			@turn += 1
			return true
		else
			return false
		end

	end

private
	def generate_code
		4.times do
			@code_maker << CODE.sample
		end
	end
	# else next turn

end
