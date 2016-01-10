class Player

	def initialize(board)
		@board = board
		@move = nil
	end


	def make_move(turn)
		row = turn
		get_input
		@board.add_move(@move, row)
	end


	def get_input
		puts "Enter move: "
		arr = gets.chomp.split('')
		if input_valid?(arr)
			@move = arr
		else
			get_input
		end
	end


	def input_valid?(arr)
		if arr.length != 4
			puts "Please input four letters"
			return false
		else
			arr.all? {|chr| @board.class::COLORS.include?(chr)}
		end
	end

end