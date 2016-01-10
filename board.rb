class Board

	COLORS = %w(r b g y p o)
	attr_reader :win_code
	def initialize
		@board = []
		setup
		create_code
	end

	def setup
		12.times do |row|
			@board[row] = %w(_)*4, []
		end
	end

	def create_code
		@win_code = %w(r b g y)
	end

	def render
		puts "~"*40
		(1..12).each do |row|
			puts "#{@board[-row][0]}#{@board[-row][1]}"
			puts ""
		end
		puts "~"*40
	end

	def full?(turn)
		turn > 11
	end

	def winning_combination?(turn)
		row = turn - 1
		@board[row][0] == @win_code
	end

	def add_move(move, row)
		check_feedbacks(move)
		@board[row] = move, @feedback
	end

	def red_feedbacks(move)
		4.times do |idx|
			if move[idx] == @win_code[idx]
				@hash[idx] = "R"
			end
		end
	end


	def white_feedbacks(move)
		move.each do |color|
			4.times do |idx|
				if color == @win_code[idx]
					@hash[idx] = "W" unless @hash.has_key?(idx)
				end
			end
		end
	end

	def check_feedbacks(move)
		@feedback = []
		@hash = {}
		red_feedbacks(move)
		white_feedbacks(move)
		@hash.each do |key, val|
			@feedback << val
		end
	end
end