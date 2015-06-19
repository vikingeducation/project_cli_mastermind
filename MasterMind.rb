require 'colorize'
require 'pry'

class MasterMind
  def initialize
    # Create secret code
    # Create game board
  end

  def main_loop
    # Print the board
    # Prompt the player for a guess
    # Check if game_end?
    # if not 
    # increment guesses
    # get feedback on guess
    # loop
  end

  def game_end?
    # player_quit?
    # guess_correct?
    # player out of guesses?
    
  end

  def player_quit
    # print game over
    # board reveal code
    # exit 
  end

  def guess_correct
    # SecretCode.check_code
    # if true print victory message
    # board reveal code
    # exit
  end

  def player_guesses
    # If player.guesses remaining == 0
    # print out of guesses
    # board reveal code 
    # exit   
  end
  
  
end

class SecretCode
  #attr_reader :code

  COLORS = [:r, :g, :b, :y, :c, :m]

  def initialize
    @code = create_secret_code
  end

  def correct_code?(guess)
    if guess == @code
      return true
    end 
  end

  def feedback(guess)
    feedback = []
    remaining_guess = []
    remaining_code = []

    # Add black pegs to feedback, if guess is exactly correct
    # if not, add guess value, and code value of the same index
    # to "remaining" arrays.
    guess.each_with_index do |guess_v, guess_i|
      if guess[guess_i] == @code[guess_i]
        feedback << :b
      else
        remaining_code << @code[guess_i]
        remaining_guess << guess_v        
      end
    end

    # Check through the colors constant and see if the remaining
    # guess and code contain the same color.
    #
    # If so we need to return a number of white pegs equal to the number
    # of that color in the guess if the code contains more of that color
    # or a number of white pegs equal to the number of that color in the code.
    # This fixes issues that come up when there's duplicates of a color
    # in the guess or in the code.
    COLORS.each do |color|
      if remaining_guess.include?(color) && remaining_code.include?(color)
        if remaining_code.count(color) > remaining_guess.count(color)
          (remaining_guess.count(color)).times { feedback << :w }
        else
          (remaining_code.count(color)).times { feedback << :w }
        end
      end
    end

    # Feedback is gross, is an array of arrays and contains nil arrays.
    return feedback
  end

  private

  def create_secret_code
    array = []
    4.times { array << COLORS.sample }
    array
  end
  
end

class CodeBreaker

  def initialize
    @guesses = 12
    
  end

  def get_guess
    input = ""
    loop do
      puts "#{@guesses} remain!"
      puts "Guess the code using 4 of the following colors"
      print "'r' for red, ".colorize(:light_red)
      print "'g' for green, ".colorize(:light_green)
      print "'b' for blue, ".colorize(:light_blue)
      print "\n"
      print "'y' for yellow, ".colorize(:light_yellow)
      print "'c' for cyan, ".colorize(:light_cyan)
      print "'m' for magenta.".colorize(:light_magenta)
      print "\n"
      print "Enter your guess (e.g. 'ryby') > "
      input = gets.chomp
      break if guess_valid?(input)
    end
    increment_guesses
    return input
  end

  def guess_valid?(guess)
    guess = guess.split("").keep_if { |chr| chr =~ /[rgbymc]/ }
    if guess.length == 4
      true
    else 
      puts "Invalid Format!"
      false
    end
    # return true if guess is correct format
  end  

  def increment_guesses
   @guesses -= 1 
  end
  
end

class Board
  def initialize
    # Setup blank board
    
  end

  def render_board
    # print hidden or revealed code
    # print guess or blank line
    # print guess feedback    
  end

  def store_invalid_guess
    # pack into array of invalid_guesses
    
  end

  def store_guess_feedback
    # pack into arry of feedback
    
  end

  def reveal_code
    # swap hidden code for correct guess
  end
  
  
end

def colors_test
  colors = {r: :light_red, 
            b: :light_blue, 
            g: :light_green, 
            y: :light_yellow, 
            m: :light_magenta, 
            c: :light_cyan}
  items = "rbgymc"
  array = items.split("")
  array.each do |i|
    print "(*)".colorize(
                        :color => (colors[(i.to_sym)])
                        #:background => :light_black
                        )
  end
  print "\n"
end

colors_test