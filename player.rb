# All actions related to a Player
class Player
  attr_accessor :code, :guess

  def get_guess
    instructions
    user_input = gets.chomp.strip.split(',')
    valid_input(user_input) ? @guess = user_input : get_guess
  end

  def generate_code
    instructions
    user_input = gets.chomp.strip.split(',')
    valid_input(user_input) ? @code = user_input : generate_code
  end

  def valid_input(input)
    if(input.length == 4)
      input.each do |val|

      end
    else
      false
    end
  end
  
  # Has the player fit the criteria to make a guess
  def valid_guess?
    # Is the user turns still under the maximum number of turns
  end

  private 

  def instructions
    puts "**********************************************"
    puts "Please enter your input"
    puts "Enter a colour separated by a comma"
    puts "The colours that are available are R, O, Y, G, B, P"
    puts "Example guess"
    puts "e.g. R,O,Y,G"
  end

end

# Player when the user is the not the codemaker
class Computer

  attr_accessor :code, :guess

  def generate_code
    generated_code = []
    4.times{ generated_code << COLORS[rand(6) + 1] }
    generated_code
  end
end

# Display the Board
class Board
  attr_accessor :board

# Show the board at the beginning of the game
  def initialize
    @board = Array.new(11)
  end

  def render
    # display the current state of the board
  end

# add_piece
  def add_guess(guess)
     @board.push(guess)
  end
end

# Deals with the running of the game and the rules
class Game

  attr_accessor :codemaker, :codebreaker
  
  COLORS = ["R", "O", "Y", "G", "B", "I"]

  def initialize
    @board = Board.new
  end

  def initial_setup
    puts "Do you want to be the codemaker or codebreaker?"
    puts "Enter M or B"
    puts "**********************************************"

    answer = gets.chomp.strip
    if(answer.downcase == "M")
      @codemaker = Computer.new
      @codebreaker = Player.new
    elsif(answer.downcase == "B")
      @codemaker = Player.new
      @codebreaker = Computer.new
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

    12.times do |i|
      # call the board rendering method
      @board.render
      # Ask the user whether they want to be the codemaker or codebreaker
      puts "This is guess number #{i}"
      # Ask for a guess from the player
      code = @codemaker.generate_code
      guess = @codebreaker.get_guess
      feedback = give_feedback(code, guess)

      break if game_over?
      i == 12 ? reveal_code(code)
    end 
  end

  


  # Check if the player has won the game
  def game_over?
    # Is the latest move match the code maker pattern
    if(@codemaker.code == @codebreaker.guess)
      puts "You won!"
      true
    else
      false
    end
  end

  

  def give_feedback(code, guess)
    feedback = [0,0]
    guess.each_with_index do |value, ind|
      if value == code[ind]
        feedback[0] += 1
        feedback[1] += 1
      elsif code.include?(value)
        feedback[1] += 1
      else
        feedback
      end
    end

    puts "#{feedback[0]} correct guesses in the correct position"
    puts "#{feedback[1]} correct guesses in the wrong position"

    feedback
  end

  private

  def reveal_code(code)
    puts "The winning code is #{code}"
    puts "Sorry you lost!"
  end

  
end