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
			Board.message("Please enter a guess in form B,Y,O,R")

			input = gets.strip

			process(input)
			Board.render_board( @mastermind )
		end until quit?(input)
	end



	def quit?(input)
    QUIT.include?(input)
  end

	def process( input )

		guess = input.upcase.strip.split(",").map { |x| x.to_sym }
		if @mastermind.valid_move?(guess)
			print "OK"
		else
			print "not OK"
		end

	end

	def make_guess #PLAYER

	end


end