# winning code is set
# repeats until win/lose
# code breaker inputs guess
# gets feedback

require './codebreaker'
require './code'
require './board'

class MasterMind
	# initialize method - at that point tell Code to make the winning code
	def initialize
		codebreaker = Codebreaker.new
		win_code = Code.generate
		board = Board.new
	end
	# call to board to render the current board
	# welcome message
	# gameplay
	def play
		welcome
		board.render
		input = codebreaker.get_input
		win_code.compare(input)
		
	end

	def welcome
	end
end