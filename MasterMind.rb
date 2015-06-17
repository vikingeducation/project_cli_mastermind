require 'colorize'

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
  # Constant array of colors

  def initialize
    # create secret_code 
  end

  def check_code(guess)
    # return true if guess == code
  end

  def feedback(guess)
    # return an array of feedback on the guess
  end

  private

  def create_secret_code
    # sample the array of colors, 4 times 
  end
  
end

class CodeBreaker

  def initialize
    # guesses = 12
    
  end

  def get_guess
    # loop forever
    # ask for guess
    # validate guess format
    # break if guess in valid format
  end

  def validate_guess
    # return true if guess is correct format
  end  

  def increment_guesses
   # guesses -= 1
    
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
  colors = {r: :red, b: :blue, g: :green, y: :yellow}
  items = gets.chomp
  array = items.split("")
  array.each do |i|
    print "[]".colorize((colors[(i.to_sym)]))
  end
  print "\n"
end

colors_test