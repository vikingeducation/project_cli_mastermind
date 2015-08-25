require_relative 'game_validation.rb'
require_relative 'board.rb'

class GameModel < Model
	CODEBREAKER = '1'
	CODEMAKER = '2'

	attr_accessor :board
	attr_reader :last_guess

	def initialize
		super(:validation => GameValidation.new)
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
		if @validation.valid_code?(value)
			@board.code = value.split('').map {|c| c.to_i}
		end
	end

	def role=(value)
		if @validation.valid_role?(value)
			if value == CODEBREAKER
				value = :codebreaker
			else
				value = :codemaker
			end
			@board.role = value
		end
	end

	def color=(value)
		@board.code << value.to_i
	end

	def guess=(value)
		@last_guess = value
		if @validation.valid_code?(value)
			value.chars.each do |c|
				@board << c.to_i
			end
			@board.resolve
		end
		@board
	end

	def to_s
		@board.to_s
	end

	def role?
		@board.role
	end

	def code?
		@board.code?
	end

	def guess?
		row = @board.resolved.first
		row.normalize == @last_guess if row
	end

	def win?
		if @board.role == :codebreaker
			return @board.code_cracked?
		else
			return @board.without_guesses?
		end
	end

	def lose?
		if @board.role == :codebreaker
			return @board.without_guesses?
		else
			return @board.code_cracked?
		end
	end

	def codebreaker?
		@board.role == :codebreaker
	end

	def codemaker?
		@board.role == :codemaker
	end
end