require './board.rb'
require './player.rb'

require 'better_errors'

class Game

	@num_players=0
	@code=[]

	def initialize
		@board = Board.new
	end

	def welcome
		puts "Welcome to MasterMind!"
	end

	def number_of_players
		puts "How many players (1 or 2)? "
		@num_players=gets.chomp.to_i
		# @num_players.to_i!
		# print @snum_players
		# until validate_num_players(@num_players) do
		# 	puts "Invalid Selection! You must select either 1 or 2. Please select again:"
		# end
		until validate_num_players(@num_players) do
			puts "Invalid selection!\nHow many players (1 or 2)?"
			@num_players=gets.chomp.to_i!
		end
	end

	def validate_num_players(num)
		[1,2].include?(num) ? true : false
	end

	def validate_role(num)
		@num_players.to_downcase==["codebreaker","codemaker"].any? ? true : false
	end

	def get_role
		puts "Are you codemaker or codebreaker?"
		role=gets.chomp
		until validate_role(role) do
			print "Invalid selection. You must select 'codebreaker' or 'codemaker'.\nPlease reenter:"
			role=gets.chomp
		end
		role
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

	def win?(guess)
		guess==@code ? true : false
	end

	def play
		welcome
		# ask if 1-player or 2-player
		@num_players=number_of_players
		# puts @num_players
		# break if quit?
		codebreaker = Player.new("codebreaker")
		codemaker = Player.new("codemaker")
		if @num_players==1
			# puts "Are you codemaker or codebreaker?"
			role = get_role
			# until validate_role(role) do
			# 	put "Invalid selection!\nYou must select either \"codemaker\" or \"codebreaker\": "
			# end
			role=="codebreaker" ? @code = codemaker.generate_code : @code=codemaker.manually_set_code
		else
		# if 2-player
			@code=codemaker.manually_generate_code
		end

		counter = 0
		feedback_history=[]
		guess_history=[]
		@board=Board.new
		@board.render
		12.times do
			# get guess from codebreaker
			guess=codebreaker.ask_for_guess
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
		if counter == 12
			puts "You lost!"
		else puts "you won in #{counter} turns"
			# you lose
		#  if counter < 12
			# you won in #{counter} turns
		end

	end

end

g=Game.new
g.play