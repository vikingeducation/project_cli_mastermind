require_relative './computer.rb'
require_relative './human.rb'
require_relative './peg.rb'
require_relative './row.rb'
require_relative './board.rb'

class Mastermind
  def initialize
    @board = Board.new
    choose_role
  end

  def instructions
    puts "These are the colors: yellow, green, blue, purple, orange, brown."
    puts "Guess four colors in the format 'yellow, red, blue, purple' "
    puts "Try to guess all possible colors in the correct order"
  end

  def choose_role
    puts "Do you want to be a codemaker or codebreaker?"
    role = gets.chomp
    if role == 'codebreaker'
        @codebreaker = Human.new
        @codemaker = Computer.new
    elsif role == 'codemaker'
        @codemaker = Human.new
        @codebreaker = Computer.new
    else
        puts "Invalid input"
        choose_role
    end
  end

  def render
    puts @board.to_s
  end

  def play
    instructions

    @board.create_solution(@codemaker.pick_solution)

    loop do
      if guess = @codebreaker.make_a_guess

        @board.add_guess_row(guess)

        response = respond_to_guess
        if response[:full_match] == 4
            puts "Codebreaker Wins!"
            break
        elsif @board.guesses.length == 12
            puts "Codemaker Wins!"
            break
        else            
            @board.add_response(response)
        end
        render
      else
        puts "Please enter a valid input"
      end
    end
  end

  def respond_to_guess
    guess = @board.guesses.last.slots
    solution = @board.solution_row.slots
    response = { full_match: 0, color_match: 0 }
    guess_colors = {}
    solution_colors = {}

    (0..3).each do |index|
      if guess[index].color == solution[index].color
        response[:full_match] += 1
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
          response[:color_match] += 1
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


