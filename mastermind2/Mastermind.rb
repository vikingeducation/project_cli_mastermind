# Game Board is generated (GAME)
# Players are established


class Mastermind

	attr_accessor :board, :code_maker
	attr_reader :cpu_guess

	NUM_ROWS = 12
	NUM_COLS = 4
	CODE = [ "R", "G", "B" ]


	def initialize( game_state = nil )

		@code_maker = []
		@cpu_guess = []

		if Player.select_player == 'BREAKER'
			generate_code
		end

		@board = Hash.new(0)
		@turn = 0

	end




	def check_victory?( guess )
		if @code_maker == guess

			Board.message(%q(You Win! Let's play again))
			game_reset

		end
	end


	def game_reset

		result

		Player.new

	end


	def determine_hints( guess )

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



	def result

		puts "The Code was : #{@code_maker.join}"

	end




	def position_match( guess, code, hint )

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
			increment_turn
			return true
		else
			return false
		end

	end


	def increment_turn
		@turn += 1
	end


	def max_turn
		@turn == 12
	end


	def generate_guess

		@cpu_guess = []

		@cpu_guess << CODE.sample until @cpu_guess.count == 4

		increment_turn

		return @cpu_guess

	end






private

	def generate_code

		4.times {	@code_maker << CODE.sample }

	end



end
