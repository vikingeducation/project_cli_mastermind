# Maintains Game State

class TowersOfHanoi
	def initialize(tower_height=3)
		@towers = Towers.new(tower_height)
		
		@player = Player.new(@towers)
	end
		

	def play

		puts "Welcome to Towers of Hanoi!"

		loop do
		
			@towers.render
			
			@player.get_move

			# break the loop if the game is over OR if user quits
			break if check_game_over 

		end
	end

	def check_game_over
		check_victory # || check_player_quit
	end

	def check_victory
		if @towers.tower_assembled?
			puts "Congratulations, you've won!"
			true
		else
			false
		end
	end
		
end

# Player Class which maintains player
class Player
	
	def initialize(towers)
		# pass parameters to towers
		@towers = towers
	end

	def get_move
		
		loop do

			move = ask_for_move
		
			if validate_move_format(move)
				if @towers.move_piece(move)
					break
				end
			end

		end

	end
	
	def ask_for_move
		puts "Instructions:"
		puts "Enter where you'd like to move from and to in the format '1,3'. Enter 'q' to quit"
		# gets move from command line

		input = gets.strip
		exit if input == 'q'

		input.split(",").map(&:to_i)
	end

	def validate_move_format(move)
		if move.is_a?(Array) && move.size == 2
			true
		else
			puts "Your move is in an improper format!"
		end
	end

end

# Maintains tower's state

class Towers
	def initialize(tower_height)
		# sets up 2 empty towers 
		@towers = Array.new(2) { Array.new }

		# generates and shifts in first tower based on tower_height
		first_tower = (1..tower_height).to_a.reverse
		@towers.unshift(first_tower)
		@tower_height = tower_height
	end

	def render
		@towers.each do |tower|
			p tower
		end
	end

	def move_piece(move)
		if move_valid?(move)
			@towers[move[1]-1].push(@towers[move[0]-1].pop)
		else
			false
		end
	end

	def move_valid?(move)
		if selected_correct_towers?(move)
			move_available?(move)
		end
	end

	def selected_correct_towers?(move)
		if (1..3).include?(move[0]) && (1..3).include?(move[1])
			true
		else
			puts "Please choose towers 1-3 for moves"
		end
	end

	def move_available?(move)
		if @towers[move[1]-1].empty?
			true
		elsif @towers[move[0]-1][-1] < @towers[move[1]-1][-1] 
			true
		else
			puts "You can't place a bigger piece ontop of a smaller piece."
		end
	end

	def tower_assembled?
		 @towers[1].size == @tower_height || 
		 @towers[2].size == @tower_height
	end

end


puts "How many pieces would you like to play with? (3-8)"
tower_height = gets.chomp.to_i
t = TowersOfHanoi.new(tower_height)
t.play

