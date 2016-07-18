require_relative './codebreaker.rb'
require_relative './codemaker.rb'
require_relative './codecolor.rb'

class Game
	QUIT_CMDS = ['q','quit','exit']
	MAX_ATTEMPTS = 12
	include Codecolor

	def initialize
		@codemaker = Codemaker.new
		@codebreaker = Codebreaker.new
		@guess_code = ""
	end

	def run
		MAX_ATTEMPTS.times do
			@codebreaker.render

			get_user_input
			break if quit?

			split_code = @guess_code.split(',')

			@codebreaker.make_guess(split_code)
			@codebreaker.make_pegs(@codemaker.code)

			@codebreaker.won?(@codemaker.code)
		end
		@codebreaker.render
		puts @codemaker.code
	end

	private

	def quit?
		QUIT_CMDS.include?(@guess_code)
	end

	def get_user_input
		puts "Enter your guess code. (r),(g),(b),(y),(bl),(o),(br),(w). Example: r,b,y,b --"
		@guess_code = gets.chomp
	end

end