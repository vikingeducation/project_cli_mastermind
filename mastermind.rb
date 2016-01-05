
COLORS = [ "yellow", "green", "purple", "orange", "blue", "brown"]

class Peg
    attr_accessor :color
    def initialize (color)
        @color = color
    end
end

class Row 

    attr_accessor :slots
    def initialize
        @slots = []
    end

    def populate_row ( colors )
        colors.each do | color |
            @slots << Peg.new( color )
        end
    end

end

class Board

    attr_accessor :solution_row
    def initialize
        @solution_row = Row.new
        @guesses = []
    end

    def create_solution ( solution )
        @solution_row.populate_row ( solution )
    end

    def create_autogenerate_solution 
        solution = []
        4.times do
            solution << COLORS.sample
        end
        create_solution( solution )
    end

    def add_guess_row( guess )
        @guesses << guess
    end



end

class Player

end


class Mastermind

    def initialize
        @board = Board.new
    end

    def instructions
        puts "make a guess"
        puts "if incorrect, make another"
    end

    def play
        instructions
    end

    def check_win?

    end

    def respond_to_guess

    end

end

test_board = Board.new
test_board.create_autogenerate_solution()
puts test_board.solution_row.slots.each {  |peg| puts peg.color }

# the_mind = Mastermind.new
# the_mind.play


