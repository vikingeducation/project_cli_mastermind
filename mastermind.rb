require './board.rb'
require './player.rb'

class Mastermind

	def initialize
		@turn = 1
		@board = Board.new
		@player = Player.new(@board)
	end

	def play
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
			puts "You Won"
			puts "the winning combination was #{@board.win_code}"
			return true
		end
		false
	end

	def lose
		if @board.full?(@turn)
			@board.render
			puts "You lost"
			return true
		end
		false
	end
end


game = Mastermind.new
game.play