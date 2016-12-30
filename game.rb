
# game.rb
require_relative 'board'
require_relative 'player'
require_relative 'computer'

# Deals with the running of the game and the rules
class Game
  attr_accessor :codemaker, :codebreaker
  
  $colors = %w(R O Y G B P)

  def initialize
    @board = Board.new
  end

  def initial_setup
    puts "Do you want to be the codemaker or codebreaker?"
    puts "Enter M or B"
    puts "**********************************************"

    answer = gets.chomp.strip
    if(answer.upcase == "M")
      @codemaker = Player.new
      @codebreaker = Computer.new
    elsif(answer.upcase == "B")
      @codemaker = Computer.new
      @codebreaker = Player.new
    else 
      puts "Please ensure you enter your input correctly"
      initial_setup
    end
  end

  # The game starts here
  def play
    
    puts "Welcome to Mastermind"
    puts "**********************************************"

    initial_setup
    code = @codemaker.generate_code
    12.times do |i| 
      puts "This is guess number #{i+1}"
      guess = @codebreaker.get_guess
      @board.add_guess(guess)
      feedback = give_feedback(code, guess)

      @board.render(feedback)

      break if game_over?
      if (i == 11)
        reveal_code(code) 
      end
    end 
    puts "Game over!"
  end

  # Check if the player has won the game
  def game_over?
    # Is the latest move match the code maker pattern
    cm_code = @codemaker.code
    cb_guess = @codebreaker.guess
 
    if(cm_code == cb_guess)
      puts "Codebreaker won!"
      true
    else
      false
    end
  end

  def give_feedback(code, guess)

    feedback = [0,0]
    code_col_count = colour_count(code)
    guess_col_count = colour_count(guess)

    puts "colour uniq #{code_col_count}"
    puts "colour uniq #{guess_col_count}"

    # Exact guesses
    guess.each_with_index do |value, ind|
      if(value == code[ind])
        feedback[0] += 1
        code_col_count[value.to_sym] -= 1
      end
    end

    # Near guesses
    guess.each do |value|
      puts "colour uniq the value #{value} and #{code_col_count[value.to_sym]}"

      if(code.include?(value) && (code_col_count[value.to_sym] > 0))
        feedback[1] += 1
        code_col_count[value.to_sym] -= 1
      end
    end
    feedback
  end


  private

  def reveal_code(code)
    puts "The winning code is #{code}"
    puts "Codemaker wins and the codebreaker has lost!"
  end 

  # Frequency of each colour in the generated code
  def colour_count(code)
    temp = Hash.new(0)
    code.each do |x|
      temp[x.to_sym] +=1
    end
    temp
  end
end

# colour_count = {R: 0, Y: 2, G: 1}
# solution = ["Y", "R", "Y", "G"]
# guess1   = ["R", "R", "R", "R"]

