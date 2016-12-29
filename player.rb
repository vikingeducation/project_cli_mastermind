# All actions related to a Player
class Player
  attr_accessor :code, :guess

  def get_guess
    instructions
    user_input = clean_input(gets.chomp)
    valid_input(user_input) ? @guess = user_input : get_guess
  end

  def generate_code
    instructions
    user_input = clean_input(gets.chomp)
    valid_input(user_input) ? @code = user_input : generate_code
  end

  def valid_input(input)
    if(input.length > 4)
      puts "Too many colours"
      false
    elsif(input.length < 4)
      puts "Not enough colours"
      false
    else
      letter_len = true
      input. each do |x|
        # next in loops instead of conditionals
        next unless (x.length != 1)  
          letter_len = false
      end
      letter_len
    end
  end

  private 

  def instructions
    puts "**********************************************"
    puts "Please enter your input"
    puts "Enter a colour separated by a comma"
    puts "The colours that are available are R, O, Y, G, B, P"
    puts "Example guess"
    puts "e.g. R,O,Y,G"
    puts "**********************************************"
  end

  def clean_input(raw_input)
    user_input = raw_input.strip.upcase.split(',')
  end

end

# Player when the user is the not the codemaker
class Computer

  attr_accessor :code, :guess

  def generate_code
    generated_code = []
    4.times{ generated_code << $colors[rand(6)] }
    puts "#{generated_code}"
    generated_code
  end
end

# Display the Board
class Board
  attr_accessor :board

# Show the board at the beginning of the game
  def initialize
    @board = []
  end

  def render(feedback=[0,0])
    # display the current state of the board
    @board.each do |x|
      x.each do |y|
        print " #{y} |"
      end
      p "-----------------"
    end

    if(board.length != 0)
      puts "#{feedback[0]} exact peg(s) in the correct position"
      puts "#{feedback[1]} close peg(s) in the wrong position"
    end
  end

# add_piece
  def add_guess(guess)
     @board.push(guess)
  end
end

# Deals with the running of the game and the rules
class Game

  attr_accessor :codemaker, :codebreaker
  
  $colors = %w(R, O, Y, G, B, P)

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
      # call the board rendering method
      @board.render
      
      puts "This is guess number #{i+1}"
      # Ask for a guess from the player
      guess = @codebreaker.get_guess
      @board.add_guess(guess)
      feedback = give_feedback(code, guess)

      @board.render(feedback)

      break if game_over?
      if (i == 11)
        reveal_code(code) 
      end
    end 
  end

  


  # Check if the player has won the game
  def game_over?
    # Is the latest move match the code maker pattern
    if(@codemaker.code == @codebreaker.guess)
      puts "Codebreaker won!"
      true
    else
      false
    end
  end

  

  def give_feedback(code, guess)
    feedback = [0,0]
    guess.each_with_index do |value, ind|
      if(value == code[ind])
        feedback[0] += 1
        feedback[1] += 1
      elsif(code.include?(value))
        feedback[1] += 1
      end
    end
    feedback
  end

  private

  def reveal_code(code)
    puts "The winning code is #{code}"
    puts "Codemaker wins and sorry codebreaker has lost!"
  end

  
end