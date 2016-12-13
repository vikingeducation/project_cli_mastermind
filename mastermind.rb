require_relative 'board'
require_relative 'player'

class Mastermind
	def initialize
		@board = Board.new
		@rounds_played = 0
	end

	def check_input(string)
		if string == "y"
			true
		elsif string == "n"
			true
		else
			false
		end
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

	def print_instruction
		puts "To play a round or enter a code, enter 4 letters each from 'A' to 'G' inclusive"
		puts "For example 'ABCD' represents : \n"
		puts "#{Peg.print_pegs(["A", "B","C", "D"])}"
		puts "\nWhile 'EFGA' represents : \n"
		puts "#{Peg.print_pegs(["E", "F","G", "A"])}"
	end

	def play_a_round (player, code)
		return_val = false
		user_selection = player.make_guess
		puts "#################################\n\n"
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
			return_val = true
		end
		return_val
	end

	def play_as_code_breaker
		return_val = false
		print_instruction
		puts "Now let's start : "
		player = Player.new
		player_computer = Player.new(COMPUTER)
		code = player_computer.generate_code
		play_all_rounds(player, code)
		code
	end

	def play_all_rounds(player, code)
		while @rounds_played < 12
			finished = play_a_round(player, code)
			if finished
				finished
				return_val = finished
				break
			end
		end
		if return_val != true
			puts "#################################\n\n"
			puts "\n\nYou played 12 rounds and unfortunately could not break the code :(\n\n"
			print " " * 42
			Peg.print_pegs code
			puts "\n\n"
		end
	end

	def play_as_code_maker
		return_val = false
		print_instruction
		puts "Now enter a code : "
		player_human = Player.new
		player = Player.new(COMPUTER)
		code = player_human.generate_code
		play_all_rounds(player, code)
		code
	end

	def play
		puts "\nHello, Welcome to Mastermind!"
		puts "The items and their definitions are as below :"
		print_manual
		puts "\n"
		puts "Do you want to play as code maker?(y/n):"
		user_input = gets.chomp
		good_input_received = check_input user_input
		until good_input_received
			puts "Bad input, please try again : "
			user_input = gets.chomp
			good_input_received = check_input user_input
		end
		if user_input == "y"
			code = play_as_code_maker
		else
			code = play_as_code_breaker
		end
	end
end

game = Mastermind.new
game.play