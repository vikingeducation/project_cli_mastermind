# Towers of Hanoi

# ------------ The Game -------------------------------------------------------

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
			
			break if check_game_over 

		end
	end

	def check_game_over
		if @towers.tower_assembled?
			puts " "
			@towers.render
			puts " "
			puts "Congratulations, you've won!"
			true
		else
			false
		end
	end

end

# ------------ Player ---------------------------------------------------------

class Player
	
	def initialize(towers)
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
		puts " "
		puts "Instructions:"
		puts "Enter where you'd like to move from and to in the format '1,3'. Enter 'q' to quit"
	
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


# ------------ Towers ---------------------------------------------------------

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
		puts " "
		puts " "
		@towers.each do |tower|
			p tower
		end
		puts " "
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
loop do
	break if (3..8).to_a.include?(tower_height)
	
	puts "Please pick a tower height from 3-8"
	tower_height = gets.chomp.to_i
end

t = TowersOfHanoi.new(tower_height)
t.play

