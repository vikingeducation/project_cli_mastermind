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
    puts "make a guess"
    puts "if incorrect, make another"
  end

  def render
    puts @board.to_s
  end

  def play
    instructions

    @board.create_autogenerate_solution

    loop do
      @board.add_guess_row(@codebreaker.make_a_guess)

      if check_win?
        puts "You won!"
        break
      else
        @board.add_response(respond_to_guess)
      end

      render
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


