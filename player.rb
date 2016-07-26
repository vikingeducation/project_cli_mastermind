# Player class
class Player
  attr_accessor :name

  def initilize(name)
    @name = name
  end

  def pick_codebreaker?
    binding.pry
    true if pick_character == 1
  end

  def make_guess
    guess_instruction
    guess = gets.chomp
    until valid_guess? guess
      guess_warning
      guess = gets.chomp
    end
    guess_format guess
  end



  # Attention! The Following methods are private
  private

  def guess_format guess
    result = []
    guess.split(",").each { |color| result << color.strip }
    result
  end

  def guess_warning
    puts "Wrong guess input"
    puts "Availble colors are as follows, four colors should be inserted."
    puts "red, blue, green, yellow, white, black"
  end

  def valid_guess? guess
    valid_guess_color?(guess) && valid_guess_length?(guess)
  end

  def valid_guess_color? guess
    color_collection = ['red', 'blue', 'green', 'yellow', 'white', 'black']
    guess.split(",").all? { |color| color_collection.include? color}
  end

  def valid_guess_length? guess
    true if guess.split(",").length == 4
  end

  def guess_instruction
    puts "Make a guess in the format 'color1, color2, color3, color4'"
    puts "For Example, 'red, green, blue, white'"
    puts "Colors above are from left to right in association with the board position"
  end

  def pick_character
    puts "Please choose your character. Enter 1 for codebreaker, 2 for codemaker."
    character = gets.chomp
    until character_valid? character
      puts "Wrong input, please enter 1 for codebreaker, 2 for codemaker"
      character = gets.chomp
    end
    character
  end

  def character_valid? character
    true if character == 1 || character == 2
  end
end
