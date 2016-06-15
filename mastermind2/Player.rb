class Player

QUIT = ["q", "quit", "exit"]



	def initialize

		@mastermind = Mastermind.new

		if @mastermind.code_maker == []

		 run_player_as_maker

		else

			run_player_as_breaker

		end

	end

	def self.select_player

		input = ""

		until input == 'MAKER' || input == 'BREAKER'
			puts %q(Please enter 'maker' or 'breaker':)
			input = gets.strip.upcase
		end

		return input

	end


	def run_player_as_breaker

		begin
			# this is where the 'process' is called (m.mind)
			Board.message("Choosing from R, G or B, enter a guess in form OOOO")

			input = gets.strip

			process(input)

			Board.render_board( @mastermind )

		end until quit?(input) || @mastermind.max_turn

		@mastermind.result

	end



	def run_player_as_maker

		begin

			input = [""]

			until @mastermind.valid_move?( input )

				Board.message ("Enter the code for CPU to guess")

			  input = gets.upcase.strip.split("")
			end


			@mastermind.code_maker = input

			@mastermind.place_guess_on_board( @mastermind.generate_guess )

			Board.render( @mastermind )


		end until quit?(input) || @mastermind.max_turn


	end

	def process( input )

		guess = input.upcase.strip.split("")


		if @mastermind.valid_move?(guess)

			@mastermind.place_guess_on_board( guess )

			hint = @mastermind.determine_hints( guess )

			@mastermind.place_hint( hint )


		else

			Board.message(%q(Enter a valid guess))

		end

	end




	private

		def quit?( input )

    QUIT.include?( input )

  	end


end