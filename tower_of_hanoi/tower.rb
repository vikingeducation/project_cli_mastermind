class TowerOfHanoi

	def initialize(rings)
		@towers = Array.new(3){[]}
		@towers[0] = (1..rings).to_a
		@rings = rings
		@move = 0
	end

	def play
		puts "The lower the number, the larger the ring"
		puts "Put your move as follows:"
		puts "to move from tower 1 to tower 2: 12"
		loop do 
			render
			if check_win
				break
			else
				request_move
				make_move(@move)
			end
		end

	end

	def render
		print "\n \n 1 #{@towers[0]} \n 2 #{@towers[1]} \n 3 #{@towers[2]}\n"
	end

	def request_move
		puts "What is your move?"
		input = gets.strip.split('')
		@move = input.map { |x| x.to_i}
	end

	def make_move(move)
		# translate input to usable move
		choices = move.map {|x|x-1}
			if check_move(choices)
				@towers[choices[1]].push(@towers[choices[0]].pop)
			end
	end


	def check_move(choices)
		#confusing because HIGHER num means SMALLER disk
		if ring_spot_open?(choices)
			true
		else
			puts "Invalid move! A ring must smaller than ring below it."
			false
		end
	end

	def ring_spot_open?(choices)
		@towers[choices[1]][-1] == nil || 
		(@towers[choices[1]][-1] < @towers[choices[0]][-1])
	end

	def check_win
		if towers_assembled?
			puts "You have win."
			true
		else
			false
		end
	end

	def towers_assembled? #thanks Matt!
		@towers[1].size == @rings || 
		@towers[2].size == @rings
	end

	def check_quit
		false
	end

	def game_over?
		check_win || check_quit
	end

end

t = TowerOfHanoi.new(3)
t.play
