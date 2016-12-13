class Player
	def initialize(type = HUMAN)
		@type = type
	end

	def generate_code
		if @type == COMPUTER
			temp_arr = ["A", "B", "C", "D", "E", "F", "G"]
			sample_code = []
			4.times do
				sample_code << temp_arr.sample
			end
			sample_code
		else
			sample_code = make_guess
			sample_code
		end
	end

	def check_input(string)
		result = true
		string_arr = string.split("")
		if string_arr.size != 4
			result = result && false
		else
			temp_arr = ["A", "B", "C", "D", "E", "F", "G"]
			string_arr.each do |item|
				if ! temp_arr.include? item
					result = result && false
				else
					result = result && true
				end
			end
		end
		result
	end

	def make_guess(board = nil)
		if @type == HUMAN
			user_input = gets.chomp
			good_input_received = check_input user_input
			until good_input_received
				puts "Bad input, please try again : "
				user_input = gets.chomp
				good_input_received = check_input user_input
			end
			user_selection = user_input.split("")
			user_selection
		else
			sample_guess = generate_guess
			sample_guess
		end
	end

	def generate_guess
		temp_arr = ["A", "B", "C", "D", "E", "F", "G"]
		sample_code = []
		4.times do
			sample_code << temp_arr.sample
		end
		sample_code
	end
end