require_relative './codecolor.rb'

class Codebreaker
	include Codecolor

	attr_reader :name, :guesses_board, :pegs

	def initialize(name="Player 1")
		@name = name
		@guesses_board = []
		@pegs = []
	end

	def render
		(@guesses_board.length-1).downto(0) do |index|
			print "|| #{@guesses_board[index][0]} , #{@guesses_board[index][1]} , #{@guesses_board[index][2]} , #{@guesses_board[index][3]} || #{@pegs[index][0]} #{@pegs[index][1]}\n"
			#Loop through print msg
		end
		#@pegs.each {|peg| print "  #{peg[0]}  #{peg[1]}"}
		print "||_______________|| E C\n"
	end

	def make_guess(guess)
		@guesses_board << guess
	end

	def won?(code)
		@guesses_board[-1] == code ? true : false
	end

	def make_pegs(answers)
		temp_answer = []
		temp_guesses = []
		answers.each {|x| temp_answer << x}
		@guesses_board[-1].each { |x| temp_guesses << x}
		exact_pegs = 0
		close_pegs = 0
		0.upto(answers.size-1) do |index|
			if answers[index] == @guesses_board[-1][index]
				exact_pegs += 1
				temp_answer.delete_at(index)
				temp_guesses.delete_at(index)
			end
		end

		0.upto(temp_guesses.size-1) do |index|
			if temp_answer[index] == temp_guesses[index]
				close_pegs += 1
			end
		end

		@pegs << [exact_pegs,close_pegs]
	end



end