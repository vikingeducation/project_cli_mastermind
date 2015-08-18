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
		@board = Board.new(:debug => true)
	end

	def clear_code
		@board.code.clear
	end

	def clear_guesses
		@board.unresolved.first.clear
	end

	def code=(value)
		@board.code = value
	end

	def role=(value)
		if value == CODEBREAKER
			value = :codebreaker
		else
			value = :codemaker
		end
		@board.role = value
	end

	def color=(value)
		@board.code << value.to_i
	end

	def guess=(value)
		@board << value.to_i
		@board.resolve if @board.resolve_ready?
		@board
	end

	def to_s
		@board.to_s
	end

	def code?
		@board.code?
	end

	def win?
		if @board.role == :codebreaker
			return true if @board.win?
			return false if @board.lose?
		else
			return false if @board.win?
			return true if @board.lose?
		end
	end

	def lose?
		if @board.role == :codebreaker
			return false if @board.win?
			return true if @board.lose?
		else
			return true if @board.win?
			return false if @board.lose?
		end
	end

	def codebreaker?
		@board.role == :codebreaker
	end

	def codemaker?
		@board.role == :codemaker
	end
end