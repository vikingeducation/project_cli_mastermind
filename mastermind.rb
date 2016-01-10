require './board.rb'
require './player.rb'

class Mastermind

	def initialize
		@turn = 0
		@board = Board.new
		@player = Player.new(@board)
	end

	def greetings
		puts "="*40
		puts "Welcome to CLI Mastermind".center(40)
		puts "Made by FrenchToast".center(40)
		puts "Available Colors [r b g y p o]".center(40)
		puts "To make move, enter 4 colors".center(40)
		puts "For example: rbyg".center(40)
		puts "="*40
	end

	def play
		greetings
		until game_over?
			@board.render
			@player.make_move(@turn)
			@turn +=1
		end
	end


	def game_over?
		victory || lose
	end

	def victory
		if @board.winning_combination?(@turn)
			@board.render
			puts "Congratulations, you win!"
			puts "Your code was: #{@board.win_code}"
			return true
		end
		false
	end

	def lose
		if @board.full?(@turn)
			@board.render
			puts "I'm Sorry, you lose."
			puts "Winning combination was: #{@board.win_code}"
			return true
		end
		false
	end
end


game = Mastermind.new
game.play