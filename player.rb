# player.rb
# require_relative 'game'

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