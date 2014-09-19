# Your code here!
class Computer

    COLORS = ["R", "B", "G", "M", "W", "L"]

    attr_accessor :code

    def initialize
        @code = random_sample
    end
    def random_sample 
        COLORS.sample(4)
    end
end 

class Player

    def guessing
        puts "Your color options are R, B, G, M, W, and L. Please guess four colors, space-delimited"
        guess = gets.chomp.split(" ")
    end
end 

class Game

    def initialize
        @comp = Computer.new
        @player = Player.new
    end 

    def play

        10.times do |i|

            players_guess = @player.guessing
            result = evaluate_guess(players_guess)

        end 

    end

    def evaluate_guess(players_guess) 
        players_guess.each_with_index {|color, position|
        puts "Your guess in position #{position} is correct" if match?(color) 
        puts "Your guess in position #{position} is almost correct" if almost_match?(color, position) "
        
        puts ""
    end

    def almost_match?(color) 
        @comp.code.include?(color)
    end

    def match?(color, position) 
        color == @comp.code[position]

    end
end


trial_run = Game.new
trial_run = play