require_relative 'board'

class Mastermind
	def initialize
		@board = Board.new
		@rounds_played = 0
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

	def print_manual
		pegs_hash = {
						A: "⚽  ",
						B: "🏀  ",
						C: "🏈  ",
						D: "🎾  ",
						E: "🏐  ",
						F: "🏉  ",
						G: "🎱  "
					}
		p pegs_hash
	end

	def generate_code
		temp_arr = ["A", "B", "C", "D", "E", "F", "G"]
		sample_code = []
		4.times do
			sample_code << temp_arr.sample
		end
		sample_code
	end

	def play
		puts "\nHello, Welcome to Mastermind!"
		puts "The items and their definitions are as below :"
		print_manual
		puts "\n"
		puts "To play a round, enter 4 letters each from 'A' to 'G' inclusive"
		puts "For example 'ABCD' represents : \n"
		puts "#{Peg.print_pegs(["A", "B","C", "D"])}"

		puts "\nWhile 'EFGA' represents : \n"
		puts "#{Peg.print_pegs(["E", "F","G", "A"])}"

		puts "Now let's start : "
		code = generate_code
		while @rounds_played < 12
			user_input = gets.chomp
			good_input_received = check_input user_input
			until good_input_received
				puts "Bad input, please try again : "
				user_input = gets.chomp
				good_input_received = check_input user_input
			end
			user_selection = user_input.split("")
			@rounds_played += 1
			cur_peg = Peg.new(user_selection)
			closeness = cur_peg.calculate_closeness(code)
			@board.add_round(user_selection , closeness)
			@board.render
			if(closeness[BLACK] == 4)
				puts "\n\nCongrats!! You Broke the Code in #{@rounds_played} Rounds :)"
				puts "#################################\n\n"
				print " " * 42
				Peg.print_pegs code
				puts "\n\n"
				return
			end
		end
		puts "#################################\n\n"
		puts "\n\nYou played 12 rounds and unfortunately could not break the code :(\n\n"
		print " " * 42
		Peg.print_pegs code
		puts "\n\n"
	end
end

game = Mastermind.new
game.play