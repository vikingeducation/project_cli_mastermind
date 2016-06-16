class Player

QUIT = ["q", "quit", "exit"]



	def initialize

		@mastermind = Mastermind.new

		if @mastermind.code_maker == []

		 get_player_code
		 run_player_as_maker

		else

			run_player_as_breaker

		end

	end




private



	def self.select_player

		input = ""

		until input == 'MAKER' || input == 'BREAKER'

			puts %q(Please enter 'maker' or 'breaker':)

			input = gets.strip.upcase

		end

		return input

	end




	def quit?( input )

 	  QUIT.include?( input )

	end



	def run_player_as_breaker

			input = ""

			begin

				Board.message("Choosing from R, G or B, enter a guess in form OOOO")

				input = process_input

				process( input )

				Board.render( @mastermind )

			end until quit?( input ) || ( @mastermind.max_turn )

			@mastermind.result

			@mastermind.game_reset


	end




	def run_player_as_maker

		begin

			input = ""

			@mastermind.place_guess_on_board( @mastermind.generate_guess )

			Board.render( @mastermind )

			@mastermind.check_victory?( @mastermind.cpu_guess )

			Board.message("Please enter your hint. Your code is #{@mastermind.code_maker}")

			input = gets.strip

			@mastermind.place_hint( input )

		end until quit?(input) || @mastermind.max_turn

		@mastermind.game_reset

	end


	def get_player_code

			input = [""]

			begin

				Board.message ("Enter the code for CPU to guess from R,G,B")

			  input = process_input

			end until @mastermind.valid_move?( input ) || quit?( input )

			@mastermind.code_maker = input

	end


	def process_input

		return gets.upcase.strip.split("")

	end




	def process( guess )


		if @mastermind.valid_move?(guess)

			@mastermind.place_guess_on_board( guess )

			@mastermind.determine_hints( guess )

		else

			Board.message(%q(Enter a valid guess))

		end

	end


end