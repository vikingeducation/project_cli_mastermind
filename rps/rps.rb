# Rock Paper Scissors


class Game
	
	attr_accessor :score

	def play 
    @player = Player.new
    @score = 0
    puts"Welcome to Rock, Paper, Scissors! You know the deal, just don't get beat too badly.\n\n\n"

    loop do
    	@comp_choice = Computer.new.comp_choice
    	@player_choice = @player.player_choice
    	evaluate_winner(@player_choice, @comp_choice)
    end
	end

  def evaluate_winner(player_choice, comp_choice)
			case [player_choice, comp_choice]

			when %w{ p rock }, %w{ s paper }, %w{ r scissors }
				@score += 1
				puts "The computer chose #{comp_choice}, you win!" 
				puts "You've beaten the computer #{@score} time(s)!\n\n"

			when %w{ r paper }, %w{ p scissors }, %w{ s rock }
				puts "Darn, the computer chose #{comp_choice}. You lose.\n\n"
			
			else
			  puts "It was a tie!\n\n"
			end
	end
end


class Player

	def player_choice
		puts "Please choose (r)ock, (p)aper, or (s)cissors. You may 'quit' at any time."
		choice = gets.strip
		exit if choice == 'quit'
		unless %w{r p s}.include?(choice)
			puts "Please choose in the correct format."
			player_choice
		end
		choice
	end

end


class Computer
	attr_reader :comp_choice

	def comp_choice
		%w{rock paper scissors}.sample
  end
end

game = Game.new
game.play

