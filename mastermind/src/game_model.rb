require_relative 'game_auth.rb'
require_relative 'board.rb'

class GameModel < Model
	attr_accessor :role, :turns, :board

	def initialize
		super(:auth => GameAuth.new)
		
	end

	def clear
		@role = nil
		@board = Board.new
	end

	def role=(value)
		# set up game
		@role = value
	end

	def guess=(value)
		@guess = value
	end

	def create
		self
	end

	def win?
	end

	def over?
	end
end