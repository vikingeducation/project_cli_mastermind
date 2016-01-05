require_relative './computer.rb'
require_relative './human.rb'
require_relative './peg.rb'
require_relative './row.rb'
require_relative './board.rb'

class Mastermind
  def initialize
    @board = Board.new
    @codemaker = Computer.new
    @codebreaker = Human.new
  end

  def instructions
    puts "These are the colors: yellow, green, blue, purple, orange, brown."
    puts "Guess four colors in the format 'yellow, red, blue, purple' "
    puts "Try to guess all possible colors in the correct order"
  end

  def render
    puts @board.to_s
  end

  def play
    instructions

    @board.create_autogenerate_solution

    loop do
      if guess = @codebreaker.make_a_guess

          @board.add_guess_row(guess)

          if check_win?
            puts "You won!"
            break
          else
            @board.add_response(respond_to_guess)
          end

          render
      else
        puts "Please put a valid color"
      end
    end
  end

  def check_win?
    @board.guesses.last == @board.solution_row
  end

  def respond_to_guess
    guess = @board.guesses.last.slots
    solution = @board.solution_row.slots
    response = []
    guess_colors = {}
    solution_colors = {}

    (0..3).each do |index|
      if guess[index] == solution[index]
        response << "full match"
      else
        guess_color = guess[index].color
        solution_color = solution[index].color

        if guess_colors.keys.include?(guess_color)
          guess_colors[guess_color] += 1
        else
          guess_colors[guess_color] = 1
        end

        if solution_colors.keys.include?(solution_color)
          solution_colors[solution_color] += 1
        else
          solution_colors[solution_color] = 1
        end
      end
    end

    guess_colors.each do |color, number|
      if solution_colors.keys.include?(color)
        color_matches = [solution_colors[color], guess_colors[color]].min
        color_matches.times do
          response << "color match"
        end
      end
    end

    response
  end
end

test_game = Mastermind.new
test_game.play

# the_mind = Mastermind.new
# the_mind.play


