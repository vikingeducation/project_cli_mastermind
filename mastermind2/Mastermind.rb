# Game Board is generated (GAME)
# Players are established


class Mastermind

	attr_accessor :board

	NUM_ROWS = 12
	NUM_COLS = 4
	CODE = [:R, :G, :B]

	def initialize( game_state = nil )

		if Player.select_player == 'MAKER'
			@code_maker = []
			generate_code
		else
			@code_breaker

		@board = game_state || default_state
		@turn = 0
	end

	def default_state

		Hash.new(0)

	end



	def check_victory?( guess ) #BOARD
		if @code_maker == guess
			system 'clear'
			Board.message(%q(You Win! Let's play again))
			game_reset
		end
	end


	def game_reset
		Player.new
	end


	def determine_hints( guess ) #BOARD

		hint = []
		code_dup = @code_maker.dup
		guess_dup = guess.dup

		guess_dup.each_with_index do | e, i |

				if e == code_dup[i]
					hint << :b
					code_dup[i] = ''
					guess_dup[i] = ''
				end

		end

	return position_match( guess_dup, code_dup, hint )

	end



	def lose
		#you lose
	end




	def position_match( guess, code, hint ) #BOARD

		guess.each do |x|

			hint << :w if code.include?(x) unless x == ""

		end

		return hint

	end


	def place_guess_on_board ( guess )

		@board[ @turn - 1 ] = guess

	end

	def place_hint( hint )

		@board[ @turn - 1 ] << hint

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


	def max_turn
		@turn == 12
	end

private

	def generate_code

		4.times {	@code_maker << CODE.sample }

	end
	# else next turn



end
