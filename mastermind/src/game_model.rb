require_relative 'game_auth.rb'
require_relative 'board.rb'

class GameModel < Model
	CODEBREAKER = '1'
	CODEMAKER = '2'

	attr_accessor :board

	def initialize
		super(:auth => GameAuth.new)
		clear
	end

	def clear
		@board = Board.new
	end

	def role=(value)
		@board.role = value == CODEBREAKER ? :codebreaker : :codemaker
	end

	def color=(value)
		@board.code << value.to_i
	end

	def guess=(value)
		@board << value.to_i
	end
end