# Player class
class Player

  def pick_codebreaker?
    # binding.pry
    true if pick_character == '1'
  end

  def initialize_code
    make_guess
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
    guess.split(",").each { |num| result << num.strip }
    result
  end

  def guess_warning
    puts "Wrong guess input"
    puts "Availble numbers are as follows, only four numbers should be inserted."
    puts "1, 2, 3, 4, 5, 6"
    puts ""
  end

  def valid_guess? guess
    valid_guess_num?(guess) && valid_guess_length?(guess)
  end

  def valid_guess_num? guess
    num_collection = ['1', '2', '3', '4', '5', '6']
    guess.split(",").all? { |num| num_collection.include? num.strip}
  end

  def valid_guess_length? guess
    true if guess.split(",").length == 4
  end

  def guess_instruction
    puts "Type in the format 'num1, num2, num3, num4'"
    puts "For Example, '2, 3, 3, 1'"
    puts "Numberss above are from left to right in association with the board position"
    puts ""
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
    true if character == '1' || character == '2'
  end
end
