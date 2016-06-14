# Game Board is generated (GAME)
# Players are established


class Mastermind

	attr_accessor :board

	NUM_ROWS = 12
	NUM_COLS = 4
	CODE = [:B, :O]

	def initialize( game_state = nil )
		@code_maker = []
		generate_code
		@board = game_state || default_state
		@turn = 0
	end

	def default_state

		Hash.new(0)

	end



	def check_victory?( guess ) #BOARD
		if @code_maker == guess
			Board.message(%q(You Win!))
			game_reset
		end
	end


	def game_reset
		@mastermind = Mastermind.new
		system 'clear'
	end


	def determine_hints( guess ) #BOARD

		hint = []
		code_dup = @code_maker.dup
		guess_dup = guess.dup
		# first check if the color is there
			guess.each_with_index do | e, i |

				if e == code_dup[i]
					hint << :b
					code_dup[i] = ''
					guess_dup[i] = ''
				end

				# if we create a dup of the code_maker
				# we can delete match to remove the chance of there being
				# an include? misallocation

					# if it is, put black peg
				# else
					# put a white peg
				# end
		end


		guess_dup.each do |x|

			hint << :w if code_dup.include?(x) unless x == ""
		end
			# end

#		guess.each_with_index do | e, i |

#			if e == @code_maker[i]
#				hint << :b
#			end
#			binding.pry
#		end
		# for each player color
			# does their color === cpu?
				# => true
			# else => false
	return hint

	end

	def check_exact_match( guess )

	end


	def lose
		#you lose
	end




	def position_match?( code_breaker, code_maker) #BOARD
		# check the index of the matched colors
			# cpu.index(color) == player.index(color) ?
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
			check_victory?( guess )
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
