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

class Mastermind
	def play
		guess_count = 0  #could be in Board given historical tracking
		player_1 = Codebreaker.new
		player_2 = player_1.opponent
		game = Board.new(player_2)
		while guess_count < 2
			current_ans = player_1.get_ans
			game.render(current_ans)
			# p current_ans
			# p game.solution
			guess_count += 1
		end
	end
end

class Codebreaker
	attr_reader :opponent
	def initialize
		puts "Hi! Welcome to Mastermind. You have 12 guesses to determine my sequence"
		puts "Who do you want to play against: human (0) or AI (1)?"   #when asking binary q's, use boolean!!
		@opponent = gets.chomp.to_i
		puts "Acceptable input is  r (red), b (blue), g (green), w (white) in the format r,b,g,w"
	end

	def get_ans
		puts "Enter guess:"
		current_guess = gets.chomp.split(",")
		return current_guess
	end
end

class Board
	attr_reader :solution
	def initialize(opponent)   #move this to Mastermind
		@game_state = []
		if opponent == 0
		else
			color_options = ["r","b","g","w"]
			@solution = [color_options.sample, color_options.sample, color_options.sample, color_options.sample]
		end
		return @solution
	end
	def render(new_ans)
		@game_state << new_ans
		@game_state.each_with_index do |row, index|
			print "Guess #{index+1}:    #{row.join("  ")} \n"
			#puts
		end
		puts "Solution:   o  o  o  o"
	end
end