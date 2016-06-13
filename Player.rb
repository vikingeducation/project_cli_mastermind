class Player

QUIT = ["q", "quit", "exit"]
# play
# run
# call to render
# reset
# quit


	def initialize

		@mastermind = Mastermind.new
		play

	end

	def play
		Board.render_board( @mastermind )
		run

	end

	def run
		begin
			# this is where the 'process' is called (m.mind)
			Board.message("Choosing from RGBYOP, enter a guess in form O,O,O,O")

			input = gets.strip

			process(input)
			Board.render_board( @mastermind )
		end until quit?(input) || @mastermind.max_turn
	end



	def quit?(input)
    QUIT.include?(input)
  end


	def process( input )

		guess = input.upcase.strip.split(",").map { |x| x.to_sym }
		if @mastermind.valid_move?(guess)
			if @mastermind.check_victory?( guess )
				Board.message(%q(You Win!))
				@mastermind = Mastermind.new
			end
		else
			Board.message(%q(Enter a valid guess))
		end

	end

	def make_guess #PLAYER

	end


end