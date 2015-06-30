=begin
1. Create an the answer (class CreateAns)
2. class Codebreaker
	- current player solution
	- command line interface: Have the user guess the answer
	- decide who do you want to play against: human (0) or AI (1)
3. Check if the answer is correct (class Pegset)
	- if yes, break from program and output WIN message
	- if no, return to guess
	- return pegset - correct color and position, correct color not position
4. Class Mastermind - main to run the program
	- 12 guesses allowed, keep track of guess number
	- if 12, break from program and output LOSE message
	- if no, have the user guess again
	- call Pegset
5. Class Board
	- create initial state of the board
	- store the historical state of the board
	- render method: output history of the game
#6. Class CodeMaker (not using right now)
=end

require './deep_dup'

#@board.add_peg_set(Pegset.new)
#pegs = Pegset.new(solution, guess)

class Mastermind
	def play
		guess_count = 0  #could be in Board given historical tracking
		player_1 = Codebreaker.new
		player_2 = player_1.opponent
		solution = create_solution(player_2)
		game = Board.new
		test = Pegset.new
		while guess_count < 12
			current_ans = player_1.get_ans(guess_count)
			result_of_test = test.check_solution(solution, current_ans)
			break if result_of_test == "You WIN!"
			game.add_turn(current_ans, result_of_test)
			game.render
			guess_count += 1
		end
	end

	def create_solution(player_2)
		solution = []
		if player_2 == 0
		else
			color_options = ["r","b","g","w"]
			(color_options.length).times do
				solution << color_options.sample
			end
		end
		return solution
	end
end

class Codebreaker
	def initialize
		puts "Hi! Welcome to Mastermind. You have 12 guesses to determine my sequence."
	end

	def opponent
		puts "Who do you want to play against: human (0) or AI (1)?"   #when asking binary q's, use boolean!!
		opponent = gets.chomp.to_i
	end

	def get_ans(guess_no)
		puts "Input - r(red), b(blue), g(green), w(white) in the format r,b,g,w"
		puts "Enter guess (#{guess_no + 1} / 12):"
		current_guess = gets.chomp.split(",")
	end
end

class Board
	def initialize
		@game_state = []
		@peg_state = []
	end

	def add_turn(new_ans, test_result)
		@game_state << new_ans
		@peg_state << test_result
	end

	def render
		p @peg_state[0]
		p @peg_state[1]
		@game_state.each_with_index do |row, index|
			print "Guess #{index+1}:    #{row.join("  ")}  "
			puts "Result: " + " \u2713 "*@peg_state[index][0] + " o "*@peg_state[index][1] + " x "*(4-(@peg_state[index][0]+@peg_state[index][1]))
		end
		puts "Solution:   o  o  o  o"
	end

end

class Pegset
	def check_solution(solution_needing_duplication, guess_needing_duplication)
		solution = solution_needing_duplication.deep_dup
		guess = guess_needing_duplication.deep_dup

		if solution == guess
			puts "You WIN!"
		else
			compare(solution, guess)
		end
	end

	def compare(solution, guess)
		#p solution
		#p guess
		exactly_correct = exact_matches(solution, guess)
		color_correct = color_only_matches(solution,guess) - exactly_correct
		#p exactly_correct
		#p color_correct
		return [exactly_correct, color_correct]
	end

	def exact_matches(solution, guess)
		count = 0
		match_color_position = 0
		while count < solution.length
			if (solution[count] == guess[count])
				match_color_position += 1
			end
			count += 1
		end
		return match_color_position
	end

	def color_only_matches(solution, guess)
		i = 0
		match_only_color = 0
		while i < solution.length
			if solution.include?(guess[i])
				solution[solution.index(guess[i])] = 0
				match_only_color += 1
			end
			i += 1
		end
		return match_only_color
	end
end
