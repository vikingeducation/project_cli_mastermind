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
    puts "Example guess e.g. R,O,Y,G"
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
    @code = generated_code
  end

  def get_guess
    generated_guess = []
    4.times{ generated_guess << $colors[rand(6)] }
    puts "#{generated_guess}"
    @guess = generated_guess
  end

end

# Display the Board
class Board
  attr_accessor :board

# Show the board at the beginning of the game
  def initialize
    @board = []
  end

  def render(feedback)
    # display the current state of the board
    @board.each do |x|
      x.each do |y|
        print " #{y} |"
      end
      puts ""
      puts "-----------------"
    end
    puts "#{feedback[0]} exact peg(s) are the correct colour and in the correct position"
    puts "#{feedback[1]} close peg(s) are the correct colour but in the wrong position"
  end

# add_piece
  def add_guess(guess)
     @board.push(guess)
  end
end

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
    guess.each_with_index do |value, ind|
      # puts "The current value is #{value} and the index is #{ind}"
      # puts "The code at the current index is #{code[ind]}"
      if(value == code[ind])
        feedback[0] += 1
        # feedback[1] += 1
      elsif(code.include?(value))
        feedback[1] += 1
      end
      puts "#{feedback}"
    end
    feedback
  end

  private

  def reveal_code(code)
    puts "The winning code is #{code}"
    puts "Codemaker wins and the codebreaker has lost!"
  end 
end