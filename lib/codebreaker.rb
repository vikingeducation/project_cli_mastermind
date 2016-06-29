require_relative './codecolor.rb'

class Codebreaker
	include Codecolor

	attr_reader :name, :guesses_board

	def initialize(name="Player 1")
		@name = name
		@guesses_board = []
	end

	def render
		@guesses_board.reverse.each { |guess| print "|| #{guess[0]} , #{guess[1]} , #{guess[2]} , #{guess[3]} ||\n"}
		print "||_______________||\n"
	end

	def make_guess(guess)
		@guesses_board << guess
	end

	def won?(code)
		@guesses_board[-1] == code ? true : false
	end
end