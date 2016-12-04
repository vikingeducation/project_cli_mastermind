class Player
 COLORS = ["B", "P", "R", "O", "G", "Y"]
end

class AI < Player
  def generate_code
    code = []
    4.times { code << COLORS.sample }
    code
  end

  def place_guess
    guess = []
    4.times { guess << COLORS.sample }
    guess
  end
end

class Human < Player
  def generate_code
    code = ""
    loop do 
      puts
      puts "What would you like your code to be?"
      puts "Format your answer as 'B G G R'."
      code = gets.chomp
      exit if code == 'q'
      code = code.upcase.split(" ")
      break if valid_input?(code)
    end
    code
  end

  def place_guess
    guess = ""
    loop do 
      puts "What would you like to put into this row?"
      puts "Format your answer as 'B G G R'."
      guess = gets.chomp
      exit if guess == 'q'
      guess = guess.upcase.split(" ")
      break if valid_input?(guess)
    end
    guess
  end

  def valid_input?(input)
   return true if input.all? { |item| COLORS.include?(item) } && input.size == 4
    false
  end

end