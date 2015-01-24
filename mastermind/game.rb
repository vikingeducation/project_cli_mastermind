require 'board.rb'
require 'player.rb'

class Game

	@num_players
	@code

	def initialize
		@board = Board.new
	end

	def welcome
		puts "Welcome to MasterMind!"
	end

	def number_of_players
		puts "How many players (1 or 2)? "
		@num_players=gets.chomp
		validate_num_players
	end

	def validate_num_players(num)
		@num_players.to_i==[1,2].any? ? true : false
	end

	def validate_role(num)
		@num_players.to_i==[1,2].any? ? true : false
	end

	def evaluate_guess(guess)
		feedback=[]
		i=0
		4.times do
			feedback.push("B") if feedback_black(guess, i)
			i+=1
		end
		j=0
		4.times do
			feedback.push("W") if feedback_white(guess, j)
			j+=1
		end
		feedback
	end

	def feedback_white(guess, i)
		(guess[i] != @code[i]) && (guess.count(guess[i]) != @code.count(guess[i])) && @code.include?(guess[i]) ? true : false
	end

	def feedback_black(guess, j)
		guess[j]==@code[j] ? true : false
	end

	def win(guess)
		guess=@code ? true : false
	end

	def play
		welcome
		# ask if 1-player or 2-player
		@num_players=number_of_players
		# break if quit?
		until validate_num_players(@num_players) {puts "Invalid selection!\nHow many players (1 or 2)?"}
		Codebreaker = Player.new("codebreaker")
		Codemaker = Player.new("codemaker")
		if number_of_players==1
			puts "are you codemaker or codebreaker?"
			role = gets.chomp
			until validate_role(role) {put "Invalid selection!\nYou must select either \"codemaker\" or \"codebreaker\": "}
			role=="codebreaker" ? @code = Codemaker.generate_code : @code=Codemaker.manually_set_code
		else
		# if 2-player
			@code=Codemaker.manually_set_code
		end

		counter = 0
		feedback_history=[]
		guess_history=[]
		@board=Board.new
		@board.render
		12.times do
			# get guess from codebreaker
			guess=Codebreaker.ask_for_guess
			guess_history.push(guess)
			counter+=1
			# compare code vs guess
			feedback=evaluate_guess(guess)
			feedback_history.push(feedback)
				break if win?(guess)
			@board.give_feedback(feedback)
			# rerender board
			@board.rerender(counter, guess_history, feedback_history)
			counter+=1
		end
		if counter == 12 ? puts "You lost!" : puts "you won in #{counter} turns"
			# you lose
		#  if counter < 12
			# you won in #{counter} turns

	end

end

g=Game.new
g.play