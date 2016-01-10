class Board

	COLORS = %w(r b g y p o)
	attr_reader :win_code
	def initialize
		@board = []
		@feedback = []
		setup
		@win_code = create_code
	end

	def setup
		12.times do |row|
			@board[row] = %w(_)*4
		end
	end

	def create_code
		%w(r b g y)
	end

	def render
		12.times do |row|
			print @board[-row]
			print @feedback
			puts ""
		end
	end

	def full?(turn)
		turn > 12
	end

	def winning_combination?(turn)
		row = turn - 1
		@board[row] == @win_code
	end

	def add_move(arr, row)
		@board[row] = arr
		puts "get here"
		feedbacks(row)
	end

	def red_feedback(code, input)
		4.times do |idx|
			if code[idx] == input[idx]
				code.delete_at(idx)
				input.delete_at(idx)
				@feedback << "R"
			end
		end
	end


	def white_feedbacks(code, input)
		input.each do |color|
			code.length.times do |idx|
				if code[idx] == color
					code.shift!
					@feedback << "W"
				end
			end
		end
	end

	def feedbacks(row)
		code = @win_code
		input = @board[row]
		@feedback = []
		red_feedback(code, input)
		white_feedbacks(code, input)
	end
end